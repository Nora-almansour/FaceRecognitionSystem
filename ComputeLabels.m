function [Trainlabels TestLabels] = ComputeLabels
    load FERRET_A_L;
    load FERRET_B_L;
    nA = size(FERRET_A_L, 1);
    nB = size(FERRET_B_L, 1);
    Trainlabels = zeros(nA,1);
    TestLabels  = zeros(nB,1);
    
    % Train Labels
    label  = FERRET_A_L{1};
    nlabel = str2double(label(1:5));
    Trainlabels(1) = 1;
    
    ID = 1;
    plabel =  nlabel;
    
    for i = 2:nA;
        label  = FERRET_A_L{i};
        nlabel = str2double(label(1:5));
        if(nlabel ~= plabel);
            ID = ID+1;
            plabel =  nlabel;
        end;
        Trainlabels(i) = ID;
    end;
    
    % Test Labels
    for i = 1:nB;
        label = FERRET_B_L{i};
        indx = strmatch(label(1:5), FERRET_A_L);
        TestLabels(i) = Trainlabels(indx(1));
    end; 
end


