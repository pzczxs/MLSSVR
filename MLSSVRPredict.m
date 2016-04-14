function [predictY, TSE, R2]= MLSSVRPredict(tstX, tstY, trnX, alpha, b, lambda, p)
% 
% [predictY, TSE, R2]= MLSSVRPredict(tstX, tstY, trnX, alpha, b, lambda, p);  
% 
% author: XU, Shuo (pzczxs@gmail.com)
% date: 2011-12-25
% 
if (size(tstY, 2) ~= numel(b)) 
    display('The number of column in tstY and b must be equal.'); 
    return; 
end

m = size(tstY, 2); 
l = size(trnX, 1); 

if (size(alpha, 1) ~= l || size(alpha, 2) ~= m) 
    display('The size of alpha should be ' + l + '*' + m); 
    return; 
end

tstN = size(tstX, 1); 
b = b(:); 
    
K = Kerfun('rbf', tstX, trnX, p, 0); 
predictY = repmat(sum(K*alpha, 2), 1, m) + K*alpha*(m/lambda) + repmat(b', tstN, 1); 

%calculate Total Squared Error and squared correlation coefficient
TSE = zeros(1, m); 
R2 = zeros(1, m); 
for t = 1: m
    TSE(t) = sum((predictY(:, t) - tstY(:, t)).^2); 
    R = corrcoef(predictY(:, t), tstY(:, t)); 
    if size(R, 1) >  1
        R2(t) = R(1, 2)^2; 
    end
end
