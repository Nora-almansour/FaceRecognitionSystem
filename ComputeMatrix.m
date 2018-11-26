function [PCAfeatues] = ComputeMatrix(data1)

nr1 = size(data1, 1);

fprintf('Creating Image Matrix matrix\n');
% ---------------------------------------
% Set-up the parameters for LBP histogram
% ---------------------------------------
im = imread (char(data1(1)));

Imsize    = size(im(:),1); % I put 1 ; "Size inputs must be scalar."
PCAfeatues = zeros(Imsize, nr1); 
% ---------------------------------------
% Creating LBP Histogram matrix
% ---------------------------------------
% For Data1
for i = 1 : nr1
    im = imread (char(data1(i)));
    PCAfeatues(:,i) = im(:); 
    clear im;
end;





