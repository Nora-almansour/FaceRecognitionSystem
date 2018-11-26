function accuracy = ClassifyByKNN (train_d, train_l, test_d, test_l,metric,k)
Class = cvKnn(test_d, train_d, train_l, k, @distFun, metric);
    result = (Class==test_l); % to classify more than one class. if computed class== test label ==> result=1 else result=0
    correct = sum(result);
    accuracy = correct*100/size(Class,2); % %age of correctly classified samples
 % Correctly classified Masses
    [r,c,v] = find(test_l);
    numMass = size(v,2);
    result = Class & test_l;
    TP = sum(result); 
    FN = numMass - TP;

    % Correctly classified Normals
    [r,c,v] = find(~test_l);
    numNorm = size(v,2);
    result = ~Class & ~test_l;
    TN    = sum(result); 
    FP    = numNorm - TN;

    % Classification accuracy
    RR.Accur = 100*(TP+TN)/(TP+FP+FN+TN);
    % True Positve Rate or Sensitivity or recal
    RR.TPR = TP*100/(TP+FN);
    % True Negative Rate or Specificity
    RR.TNR = TN*100/(FP+TN);
    % Positive Predictive Value or precision
    RR.PPV = TP*100/(TP+FP);
    % Negative Predictive Value
    RR.NPV = TN*100/(FN+TN);
end

