function [PCA_M, diagonal] = ComputePCAMtrxWithTurkTrick(trainSpace)
% =========================================================================
%Input: A matrix nxp, where n (number of rows) is the number of variable
%       and p (the number of columns) is the number of patterns
%Output: 
%   PCAM: A matrix nxp where p is the number of patterns
% =========================================================================
% -------------------------------------------------------------------------
% Calculate mean sample vector from training samples 
% -------------------------------------------------------------------------
fprintf('Zero mean\n');
psi = mean(double(trainSpace'))';
% -------------------------------------------------------------------------
% Subtract mean sample from all training samples
% -------------------------------------------------------------------------
zeroMeanSpace = zeros(size(trainSpace));
dim = size(trainSpace, 2);
zeroMeanSpace = double(trainSpace) - repmat(psi, 1, dim);
% for i = 1 : dim
%     zeroMeanSpace(:, i) = double(trainSpace(:, i)) - psi;
% end;
clear trainSpace;
% -------------------------------------------------------------------------
% PCA: Calculate eignvalues and eignvectors. Arrange eignvalues in
% ascending order
% -------------------------------------------------------------------------
% Calculate eignvalues and eignvectors
fprintf('PCA\n')
L = zeroMeanSpace' * zeroMeanSpace;         % Turk-Pentland trick (part 1)
[eigVecs, eigVals] = eig(L);

% Arrange eignvalues  in descending order
diagonal = diag(eigVals);
[diagonal, index] = sort(diagonal);
index = flipud(index);
pcaEigVecs = eigVecs(:, index);
    
pcaEigVecs = zeroMeanSpace * pcaEigVecs;    % Turk-Pentland trick (part 2)

% Normalise eignvectors to unit length
fprintf('Normalising\n')
for i = 1 : dim
    pcaEigVecs(:, i) = pcaEigVecs(:, i) / norm(pcaEigVecs(:, i));
end;
PCA_M = pcaEigVecs;

