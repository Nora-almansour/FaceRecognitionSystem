function M = CalculateTransformationMatrix(K,eigVec)

fprintf('Creating lower dimensional subspace\n');
M = eigVec(:, 1: K);

end



