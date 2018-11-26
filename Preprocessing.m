function [ train_d,train_l,test_d,test_l ] = Preprocessing( path )

% Create data files. These function will be called once
% -----------------------------------------------------
createDataLists(path); 
[train_l test_l] = ComputeLabels;
train_l = train_l';
test_l = test_l';

% Load Data Files
% ---------------
load FERRET_A_L;
load FERRET_B_L;

% Extract features using PCA
% ------------------------------------
train_d  = ComputeMatrix(FERRET_A_L);
test_d   = ComputeMatrix(FERRET_B_L);
subDim = input ('Enter subDim value') ;
[train_d, test_d]  = ExtractFeaturesWithPCA(train_d, test_d, subDim);
end