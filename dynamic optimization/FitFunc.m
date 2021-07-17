%%% FITNESS FUNCTION   You may design your own fitness function here
function [FitVal] = FitFunc(pop,features)
global  th   thawhdata traindata datatype theBCF
FitVal=0;
[n,p]=size(traindata.X);
class_ind=p+1;
FeatIndex = find(pop>th);  %Feature Index
FeatIndex=features([FeatIndex]);

X1 = traindata.X;% Features Set
X1 = X1(:,[FeatIndex]);
NumFeat = numel(FeatIndex);


D1=0;
for i=1:NumFeat
    
    %D1= D1+ mi(X1(:,[i]),Y1);
    if(datatype==2)
        [CI,dep]=my_cond_indep_fisher_z(thawhdata,FeatIndex(i),class_ind,[],n,0.01);
    elseif(datatype==1)
        dep=mi(FeatIndex(i),class_ind);
    end
    D1= D1+dep;
end
R1=0;

for i=1:NumFeat
    for j=1:i
        if not(j==i)
            
            %R1= R1+ mi(X1(:,[i]),X1(:,[j]));
            if(datatype==2)
                [CI,dep]=my_cond_indep_fisher_z(thawhdata,FeatIndex(i),FeatIndex(j),[],n,0.01);
            elseif(datatype==1)
                dep=mi(FeatIndex(i),FeatIndex(j));
            end
            R1= R1+dep;
        end
    end
end

%FeatIndex = find(pop>th)
FitVal=D1-R1;
end
