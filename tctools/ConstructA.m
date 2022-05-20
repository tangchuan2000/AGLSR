%X每列为一个数据d*n


function A = ConstructA(X, knn)
    numOfSample = size(X,2);
    E = zeros(numOfSample);
    for i = 1:numOfSample
    	for j = 1:numOfSample
            E(i, j) = (norm(X(:,i) - X(:, j)))^2;
        end
    end
    
    [B,I] = sort(E,2);
    A = zeros(numOfSample);
    for i = 1:numOfSample
    	for j = 1:numOfSample
            SumEih = 0;
            for h = 1:knn
                SumEih = SumEih + B(i, h);
            end
            for k = 1:knn
                if I(i, k) == j % i与j是领域内
                    A(i, j) = (B(i, knn + 1) - B(i, j)) / (knn * B(i, knn + 1) - SumEih);
                    break;
                end
            end
        end
    end
end