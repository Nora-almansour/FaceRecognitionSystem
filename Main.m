%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Extract LBP Features
%   By: Dr. Muhammad Hussain
%   -----------------------------------------------------------------------
%% ========================================================================
%% ========================================================================
clear all; clc; close all;
% Set-up the path
% ---------------
path = pwd;
addpath(genpath(path)); 

fprintf('FR System using PCA & KNN..\n');

%--------------------------------------------------------------
% Preprocess the system to obtained required data 
% Input: current path to get database images
% Output:
% - training and testing data as a matrix, each column vector is a sample image.
% - training and testing labels as vector
%--------------------------------------------------------------
fprintf('Preprocessing..\n');
 [train_d,train_l,test_d,test_l] = Preprocessing( path );


%--------------------------------------------------------------
% extract eigen values and eigen vectors from the training data
%--------------------------------------------------------------
[eigVec, eigVal] = ComputePCAMtrxWithTurkTrick(train_d);


%--------------------------------------------------------------
% By using certain percentage of retained information and the 
% eigen values, selecting the K PCs
%--------------------------------------------------------------
fprintf('Extrat features using PCA..\n');

percentage=input('Enter the percentage of the retained information: ex: 0.99 \n');
K = SelectKPrincipalComponents(eigVal ,percentage);


%--------------------------------------------------------------
% computr Transformation matrix M by using the number of PCs,K,
% and eigen values
%--------------------------------------------------------------
M = CalculateTransformationMatrix(K,eigVec);

%--------------------------------------------------------------
%  Extraxct features by PCA using training data and 
%  transformation marix M
%--------------------------------------------------------------
 train_d = ExtractPCAFeatures(M,train_d);
 test_d = ExtractPCAFeatures(M,test_d);
 
 % Save Features 
% train_d: a mxp matrix of features, each column is a feature vecture
% train_l: a 1xp vector, each column is a coresponding class label
% test_d : a mxq matrix of features, each column is a feature vecture
% test_l : a 1xq vector, each column is a coresponding class label

% The path to save the feature data
% ---------------------------------
featurepath = [path, '\Features_Data\'];

save([featurepath, 'PCATrain'     ], 'train_d');
save([featurepath, 'PCATrainLabel'], 'train_l');
save([featurepath, 'PCATest'      ], 'test_d' );
save([featurepath, 'PCATestLabel' ], 'test_l' );



fprintf('KNN Classification ..\n');

%--------------------------------------------------------------
% KNN classifier, to get the accuracy of classification process
%--------------------------------------------------------------
 choice=input('Enter the metric to be used with KNN classifier: enter \n1 for cityblock \n2 for cosine \n3 for Equlidean\n');
  
 if choice==1
     metric='cityblock';
 elseif choice==2
         metric='cosine';
 elseif choice==3
             metric='euclidean';
     else 
       fprintf('Error'); return;
  end
           
 accuracy = ClassifyByKNN (train_d, train_l, test_d, test_l,metric,1)

clear M; clear metric; clear percentage;  clear path; clear choice; 
clear eigVal; clear eigVec; 
