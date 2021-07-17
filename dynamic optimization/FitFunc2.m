function [FitVal] = FitFunc2(pop,features)
global  th   thawhdata traindata datatype


[n,p]=size(traindata.X);

FeatIndex = find(pop>th);  %Feature Index

if(~isempty(FeatIndex))
    FeatIndex=features([FeatIndex]);
    Y1 = grp2idx(traindata.Y);% Class Information (il utilise 1 et 2 pour representer -1 et 1)
    X1 = traindata.X;% Features Set
    X1 = X1(:,[FeatIndex]);
    NumFeat = numel(FeatIndex);
    Compute = ClassificationKNN.fit(X1,Y1,'NSMethod','exhaustive','Distance','euclidean');
    Compute.NumNeighbors = 3; % kNN = 3
    FitVal = resubLoss(Compute)/(p-NumFeat);
    
    
elseif(isempty(FeatIndex))
    
    FitVal=1;
    
end

FitVal=-FitVal;
end