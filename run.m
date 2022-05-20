close all; clear all;
addpath(genpath('.'));
DBDIR = './Dataset/';
i= 1;



 
DataName{i} = 'BBCSport'; i = i + 1;
%DataName{i} = 'BBC'; i = i + 1;
% DataName{i} = 'Caltech101-20' ; i = i + 1;


dbNum = length(DataName);
maxIter = 20;
bnorm = 1;
knn = 15; %number of neighbours for construct SIG , for obtaining the most performance, you can select it from 15 to 20, usually, set it to 15 could get an nice result
lamda = [1 10000 100];%lamda1 is not need to be tuned, here we set it to 1

testLamda = 0; % if you want to run this code on other dataset, please set testLamda = 1 to get optimal result
for dbIndex = 1:dbNum
    clear X gt ;
    dbnamePre = DataName{dbIndex};
    dbfilename = sprintf('%s%s.mat',DBDIR, dbnamePre);    
    load(dbfilename);
    gnd = gt;   
    la2=[100000 10000 1000 100 10 1 0.1 0.01];
    la3=[ 0.01 0.1 1 10 100 1000 10000 100000];
    
    if contains(dbnamePre,'Caltech101-20')          
        lamda = [1 1000 0.1]; % optimal performance parameter on this datasets
    elseif contains(dbnamePre,'BBC') && contains(dbnamePre,'BBCSport') == 0        
        lamda = [1 1 0.01]; % optimal performance parameter on this datasets
    end
        
    fprintf("running on [%s]...\n", dbnamePre);
    if (testLamda == 1)        
            maxIter = 10;
            if (dbIndex > 4)
                maxIter = 5; % for paraSense pic
            end
            
            for i = 1:length(la2)
                for j = 1:length(la3)
                    lamda(2) = la2(i);
                    lamda(3) = la3(j);
                    if (lamda(2) <= lamda(3))  % when lamda(2) <= lamda(3), the result is very bad, so we ignor this condition
                        continue;
                    end                    
                    result = SRG(X, bnorm, knn, gnd, maxIter, lamda);      %result = [acc, nmi, Pu, ARI, Fscore,Precision,Recall];
                    printResult(result, dbnamePre, lamda)
                end
            end           
    else
        tic;
       [result] = SRG(X, bnorm, knn, gnd, maxIter, lamda); %result = [acc, nmi, Pu, ARI, Fscore,Precision,Recall];
       printResult(result, dbnamePre, lamda)
        
    end    
    
end
fprintf('\n complete... \n');

function printResult(result, dbnamePre, lamda)
    str = sprintf('[%s iter:%d][ACC %.2f] [NMI %.2f] [ARI %.2f] [F-score %.2f] [Purity %.2f] [Precision %.2f] [Recall %.2f][lamda2:%.3f lamda3:%.3f] [Exe Time:%.2f] %s ',...
            dbnamePre, result(8), result(1) * 100,  result(2) * 100, result(3) * 100, result(4) * 100, result(5) * 100, result(6) * 100, result(7) * 100, lamda(2), lamda(3), toc, GetTimeStrForLog());
    fprintf('%s\n',str);    
end


