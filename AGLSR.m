%
%   X:          every colume is a sample
%   bNorm:      if or not need Normalization
%   knn:        number of neighbours for construct SIG
%   gnd:        ground truth
%   maxIter:    number of iterations
%   lamda:      paramerters
%
%   version 1.0 --May/2022
%
%   Written by Chuan Tang (tcwebmaster At 163.com)
%
%
function result = AGLSR(X, bNorm, knn, gnd, maxIter, lamda)    
    viewNum = numel(X);
    sampleNum = size(X{1},2);
    cluNum = length(unique(gnd));
    %% Normalization
%     if (bNorm == 1)
%         for v = 1: viewNum
%             X{1,v} = NormalizeFea(X{1, v}, 0);
%         end
%     end
    if bNorm == 1
        parfor i = 1:viewNum
            for  j = 1:sampleNum
                normItem = std(X{i}(:,j));
                if (0 == normItem)
                    normItem = eps;
                end;
                X{i}(:,j) = (X{i}(:,j)-mean(X{i}(:,j)))/(normItem);
            end;
        end;
    end;
    
    %% initialize S: Constructing the SIG matrices
    S = cell(1,viewNum);
    parfor v = 1:viewNum
        [S{v}, ~] = InitializeSIGs(X{v}, knn, 0);
    end
    
    
    %% initialize A D L delta
    A = cell(1,viewNum);
    D = cell(1,viewNum); 
    delta = cell(1,viewNum); %对角阵 直接求逆了
    L = cell(1,viewNum);
    parfor v = 1:viewNum
        for n = 1:sampleNum
            delta{v}(n, n) = 1/ max(sum(S{v}(:, n)), 1e-10);
            D{v}(n, n) = sum(S{v}(n, :));
        end
        A{v} = S{v} * delta{v} *  S{v}';        
        L{v} = D{v} - A{v};
    end
    SumL = zeros(sampleNum);
    for v = 1:viewNum
        SumL = SumL +  L{v};
    end
    SumL = SumL ./ viewNum;
    
    %% initialize alpha
    alpha = ones(1, viewNum).*(1/viewNum);

    
    %% initialize F
    [F, ~, evs]=eig1(SumL, cluNum, 0, 0);
    
    %% initialize Y
    tmp = diag(diag(F * F'));
    Y0 = tmp^0.5 * F;
    Y = zeros(sampleNum, cluNum);
    [~, I] = max(Y0, [], 2);
    
    for i = 1:sampleNum
        Y(i, I(i)) = 1;
    end
    C = bestMap(gnd,I);
    ACC = length(find(gnd == C))/length(gnd);
  
    error = zeros(maxIter,1);
    fz = 1e-4;
    old_cost = 0;

    bCalLost = 1;
    for iter = 1:maxIter
        tic;
        
        %% update S_v        
        parfor v = 1:viewNum
            DD = zeros(sampleNum);
            for i = 1:sampleNum
                for j = 1:sampleNum
                    DD(i,j) = norm(X{v}(:,i) - X{v}(:,j))^2 + lamda(2) / alpha(v) * ( norm(F(i, :) - F(j, :))^2);
                end
            end
            [~, idx] = sort(DD, 2); % sort each row

            S{v} = zeros(sampleNum);
            for i = 1:sampleNum
                id = idx(i, 2 : knn + 2);
                di = DD(i, id);
                S{v}(i,id) = (di(knn + 1) - di) /(knn * di(knn + 1) - sum(di(1 : knn)) + eps);                
            end
            tc1 = sum(S{v}, 2);% here test it sum to 1
        end
        
        
        %% update R
        dlg = diag(Y' * Y);      
        dlg(find(dlg == 0)) = eps;
        tmp = diag(dlg);
        Dlg_Y = (tmp)^(-0.5);
        M = Dlg_Y *  Y' * F;
        [U,~,V] = svd(M);
        R = V * U';
        
        %% update F
        parfor v = 1:viewNum
            for n = 1:sampleNum
                delta{v}(n, n) = 1/ max(sum(S{v}(:, n)), eps);
                D{v}(n, n) = sum(S{v}(n, :));% D constrained to I_c, here test it
            end
            A{v} = S{v} * delta{v} *  S{v}';        
            L{v} = D{v} - A{v};
        end
        
        SumA = zeros(sampleNum);
        for v = 1:viewNum
            SumA = SumA +  A{v} * alpha(v);
        end
        b = 0.5 * (lamda(3) / lamda(2)) * Y * Dlg_Y * R';
        
        last_F_cost = 0;
        cost = 1e-4;
        times = 0;
        
        %tic;
        while (cost - last_F_cost > 1e-5 && times < 20)
            last_F_cost = cost;
            [F, cost] = GPI(SumA, F, b);  
            times = times + 1;
        end
      
        %fprintf('GPI time:%.4f\n', toc);
        
        %% update alpha
        sumTrace = 0;
        parfor v = 1:viewNum
            sumTrace = sumTrace + (trace(F' * L{v} * F))^0.5;
        end
        for v = 1:viewNum
            alpha(v) = (trace(F' * L{v} * F))^0.5 / sumTrace;
        end
         
        %% update Y
        Y = zeros(sampleNum, cluNum);
        G = F * R;
        N1 = zeros(cluNum, 1); %n_j
        N2 = zeros(cluNum, 1); %y_j
        parfor i = 1:cluNum
            N1(i) = Y(:, i)' * Y(:, i);
        end
        
        H = Y .* G;        
        parfor i = 1:cluNum
            tmp = sum(H,1);
            N2(i) = tmp(i);
        end
                
        for i = 1:sampleNum   
            maxValue = 0;
            maxJ = 0;
            for j = 1:cluNum
                tmp1 = N2(j) + (1 - Y(i, j)) * G(i, j);
                tmp2 = max((N1(j) + (1 - Y(i, j)))^0.5, eps);
                tmp3 = N2(j) - Y(i, j) * G(i, j);
                tmp4 = max((N1(j)  - Y(i, j))^0.5, eps);
                curValue = tmp1 / tmp2 - tmp3 / tmp4;
                if (maxValue < curValue)
                    maxValue = curValue;
                    maxJ = j;
                end
            end
            if (maxJ ~= 0)
                Y(i, maxJ) = 1;
            else
                fprintf('err!\n');
            end
        end    

         
        
         %% get result
        [~, I] = max(Y, [], 2);          

        [acc, nmi, Pu] = ClusteringMeasure(gnd,I);
        ARI = RandIndex(gnd,I); % ARI
        [Fscore,Precision,Recall] = compute_f(gnd,I);% F-score   Precision  Recall
        result = [acc, nmi, ARI, Fscore, Pu, Precision, Recall, iter];

%         str = sprintf('[iter:%d] [ACC %.2f] [NMI %.2f] [ARI %.2f] [F-score %.2f] [Purity %.2f] [Precision %.2f] [Recall %.2f][lamda2:%.3f lamda3:%.3f] [Exe Time:%.2f] %s',...
%             iter, acc * 100,  nmi * 100, ARI * 100, Fscore * 100, Pu * 100, Precision * 100, Recall * 100, lamda(2), lamda(3), toc, GetTimeStrForLog());
%         fprintf('%s\n',str);      
    
        %% update lost        
        if (bCalLost == 1)
            SumL = zeros(sampleNum);
            for v = 1:viewNum
                SumL = SumL +  L{v} / alpha(v);
            end
            if(maxIter > 1) 
                error(iter) = cost_function(X, S, F, SumL, R, Y, lamda);   
                diff = abs(old_cost - error(iter))  ;

                if (iter > 2 && diff / error(iter) < fz )
                     %fprintf('diff:%.4f error(iter):%.4f old_cost:%.4f diff / error(iter):%.6f', diff, error(iter), old_cost,diff / error(iter));
                    break;
                end
                old_cost = error(iter);
            else
                %fprintf('\n');
            end                
        end
        
    end    
    clear F Y S R; 
    
end

function [F, cost] = GPI(SumA, F, b)
    %for i = 1:20
        M = 2 * SumA * F + 2 * b;
        [U,~,V] = svd(M,'econ');
        F = U * V';
        cost = F_cost(SumA, F, b);
        %fprintf('F_cost:%.6f\n', cost);
    %end

end

function err = F_cost(SumA, F, b)
    err = trace(F' * SumA * F + 2 * F' *b);
end

function err = cost_function(X, S, F, sumL, R, Y, lamda)
	sampleNum = size(X{1},2);
    sum0 = 0;
    sum1 = 0;
    viewNum = numel(X);
    parfor v = 1:viewNum
        for i = 1:sampleNum
            for j = 1:sampleNum
                nor = norm(X{v}(:, i) - X{v}(:, j));
                sum0 = sum0  + nor^2 * S{v}(i,j);
            end
        end
    end
    
    parfor v = 1:viewNum
        for i = 1:sampleNum
           sum1 = sum1 + norm(S{v}(:, i))^2;
        end
    end
    
    sum2 = trace(F' * sumL * F);
    
    dlg = diag(Y' * Y);      
    dlg(find(dlg == 0)) = eps;
    tmp = diag(dlg);
    Dlg_Y = (tmp)^(-0.5);       
    tmp = F * R - Y * Dlg_Y;
    %tmp = F * R - Y * ((Y' * Y)^(-0.5));
        
    sum3 = (norm(tmp, 'fro'))^2;
     
    err = sum0 + lamda(1) * sum1 + 2 * lamda(2) * sum2 + lamda(3) * sum3;
     %str = sprintf(' [sum0 and sum1]:[%.4f] [sum2]:[%.4f]  [sum3]:[%.4f] [cost:%.4f]', sum0 + lamda(1) * sum1, lamda(2) * sum2, lamda(3) * sum3, err);
%     str = sprintf('[all cost:%.4f] [sum0:%.4f] [sum1:%.4f] [sum2:%.4f] [sum3:%.4f]', err, sum0, sum1, sum2, sum3);
%     fprintf('%s', str);

    
end



