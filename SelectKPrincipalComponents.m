function K = SelectKPrincipalComponents(eigVal ,subDim)

% Compute how many PCs will preserve a specified percentage of the information
num = size(eigVal, 1);
numS = 0; numSub = 0;
eigVal = flipud(eigVal); 
Den  = sum(eigVal); Num = 0; 
for i = 1:num;
    Num = Num + eigVal(i);
    numS = (Num/Den);  
    if( numS < subDim); 
        numSub =  numSub +1;
    end;
end;
K = numSub;
end
