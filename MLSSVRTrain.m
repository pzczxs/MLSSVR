function [alpha, b] = MLSSVRTrain(trnX, trnY, gamma, lambda, p)
% 
% [alpha, b] = MLSSVMTrain(trnX, trnY, gamma, lambda, p);
% 
% author: XU, Shuo (pzczxs@gmail.com)
% date: 2011-12-25
% 
if (size(trnX, 1) ~= size(trnY, 1)) 
    display('The number of rows in trnX and trnY must be equal.'); 
    return; 
end

[l, m] = size(trnY); 

K = Kerfun('rbf', trnX, trnX, p, 0); 
H = repmat(K, m, m) + eye(m * l) / gamma; 

P = zeros(m*l, m); 
for t = 1: m
    idx1 = l * (t - 1) + 1; 
    idx2 = l * t; 
    
    H(idx1: idx2, idx1: idx2) = H(idx1: idx2, idx1: idx2) + K*(m/lambda); 
    
    P(idx1: idx2, t) = ones(l, 1); 
end

eta = H \ P; 
nu = H \ trnY(:); 
S = P'*eta; 
b = inv(S)*eta'*trnY(:); 
alpha = nu - eta*b; 

alpha = reshape(alpha, l, m); 
