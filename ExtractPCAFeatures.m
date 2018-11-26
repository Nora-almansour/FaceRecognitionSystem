function [features] = ExtractPCAFeatures(M,data,subDim)
% Subtract sample mean from all patterns (images)
psi = mean(double(data'))';
zeroMeanDATA = zeros(size(data));
dim = size(data, 2);
zeroMeanDATA = double(data) - repmat(psi, 1, dim);
% Project all images onto a new lower dimensional subspace (w)
features = M' * zeroMeanDATA;
clear zeroMeanDATA;
end

