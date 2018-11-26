%INPUT:
%     X is an mxn matrix, each column is a feature vector
%     Y is an mxp matrix, each column is a feature vector
%OUTPUT:
%     dM is a nxp matrix, where dM(n,p) is a distance between X(:,n) and
%     Y(:, p).
function dM = distFun(X, Y, dtype)
      r = size(X, 2);
      c = size(Y, 2);
      Z = [X Y]';
      d = pdist(Z, dtype);
      d1 = squareform(d);
      dM = d1(r+1:end, 1:r);
      dM = dM';
end

