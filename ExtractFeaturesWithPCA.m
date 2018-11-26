function [train_f, test_f] = ExtractFeaturesWithPCA(train_d, test_d, subDim)
% INPUT:
%       train_d:  matrix nxp, where n is the number of variables 
%                 and p is the number of patterns (images) in the training set.
%                 Each columns is one pattern (image)
%                 
%       test_d:  matrix nxq, where n is the number of variables and q is the
%                number of patterns (images) in the test set. Each column
%                is one pattern (image)
%       subDim:  dimension of the reduced space
% OUTPU:
%       train_f: projected train_d with PCA on subDim subspace: subDimXp
%                Extract "subDim" PCA features of training data from training
%                samples
%       train_f: projected train_d with PCA on subDim subspace: subDimXq
%                Extract "subDim" PCA features of testing data from testing
%                samples
% -------------------------------------------------------------------------
if subDim > size(train_d, 2); subDim = size(train_d, 2); end;
[PCAM, psi, eigVal] = ComputePCAMatrixWithTurkTrick(train_d);

% Compute how many PCs will preserve 95% of the information
num = size(eigVal, 1);
numS = 0; numSub = 0;
eigVal = flipud(eigVal); 
Den  = sum(eigVal); Num = 0; 
for i = 1:num;
    Num = Num + eigVal(i);
    numS = (Num/Den);  
    if( numS < 0.99); numSub =  numSub +1; end;
end;
subDim = numSub;

% Project on the slected subspace       
train_f      = TransformWithPCA(train_d, PCAM, psi, subDim);
test_f       = TransformWithPCA(test_d,  PCAM, psi, subDim);
clear PCA_M;
clear psi;