function [gamma_best, lambda_best, p_best, MSE_best] = GridMLSSVR(trnX, trnY, fold)
% 
% [gamma_best, lambda_best, p_best, MSE_best] = GridMLSSVR(trnX, trnY, fold); 
% 
% author: XU, Shuo (pzczxs@gmail.com)
% date: 2011-12-25
% 
gamma = 2.^(-5: 2: 15); 
lambda = 2.^(-10: 2: 10); 
p = 2.^(-15: 2: 3);

m = size(trnY, 2); 

% random permutation
[trnX, trnY] = random_perm(trnX, trnY); 

MSE_best = inf; 
MSE = zeros(fold, m); 
curR2 = zeros(1, m); 
R2 = zeros(1, m); 
for i = 1: length(gamma)
    for j = 1: length(lambda)
        for k = 1: length(p)
            predictY = []; 
            
            for v = 1: fold
                [train_inst, train_lbl, test_inst, test_lbl] = folding(trnX, trnY, fold, v); 
                
                [alpha, b] = MLSSVRTrain(train_inst, train_lbl, gamma(i), lambda(j), p(k));
                [tmpY, MSE(v, :)] = MLSSVRPredict(test_inst, test_lbl, train_inst, alpha, b, lambda(j), p(k)); 
                
                predictY = [predictY; tmpY]; 
            end
            
            curMSE = sum(sum(MSE)) / numel(trnY); 
            
            if MSE_best > curMSE
                gamma_best = gamma(i); 
                lambda_best = lambda(j); 
                p_best = p(k); 
                MSE_best = curMSE; 
            end
            
            fprintf('gamma = %g, lambda = %g, p = %g, mean_MSE = %g (%g, %g, %g, %g)\n', ...
                log2(gamma(i)), log2(lambda(j)), log2(p(k)), sum(sum(MSE))/numel(trnY), ...
                log2(gamma_best), log2(lambda_best), log2(p_best), MSE_best); 
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% random permutation by swapping i and j instance for each class
function [svm_inst, svm_lbl] = random_perm(svm_inst, svm_lbl)
n = size(svm_inst, 1);
rand('state', 0);
for i = 1: n
    k = round(i + (n - i)*rand());   % [i, n]
    svm_inst([k, i], :) = svm_inst([i, k], :);
    svm_lbl([k, i], :) = svm_lbl([i, k], :); 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [train_inst, train_lbl, test_inst, test_lbl] = folding(svm_inst, svm_lbl, fold, k)
n = size(svm_inst, 1); 

% folding instances
start_index = round((k - 1)*n/fold) + 1;
end_index = round(k*n/fold);
test_index = start_index: end_index;

% extract test instances and corresponding labels
test_inst = svm_inst(test_index, :);
test_lbl = svm_lbl(test_index, :);

% extract train instances and corresponding labels
train_inst = svm_inst;
train_inst(test_index, :) = [];
train_lbl = svm_lbl;
train_lbl(test_index, :) = [];
