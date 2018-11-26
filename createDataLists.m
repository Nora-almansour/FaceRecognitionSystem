function createDataLists(path)

% --------------------------------------------------
% Set this path to the directory which contains data
% --------------------------------------------------
pathd = [path, '\Database'];
% --------------------------------------------------
% Creat file for training data
% --------------------------------------------------
trainPath = strcat(pathd, '\fa_H');
FERRET_A_L = dir([trainPath, '\*.pgm']);
FERRET_A_L = {FERRET_A_L.name};
FERRET_A_L = FERRET_A_L';
save([path, '\DataFiles\','FERRET_A_L.mat'], 'FERRET_A_L');
% --------------------------------------------------
% Create file for test data
% --------------------------------------------------
testPath = strcat(pathd, '\fb_H');
FERRET_B_L = dir([testPath, '\*.pgm']);
FERRET_B_L = {FERRET_B_L.name};
FERRET_B_L = FERRET_B_L';
save([path, '\DataFiles\','FERRET_B_L.mat'], 'FERRET_B_L');

clear all;