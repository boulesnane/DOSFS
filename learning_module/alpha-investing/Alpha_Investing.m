
% Below is the main streamwise feature selection (SFS) code. It uses two helper functions, Linear_Regression and Prediction_Error
% the main function, Alpha_Investing

function [f,time] =Alpha_Investing(alg1)
global  traindata   irrelevantF thawhdata alpha thetest OFS_nf DO1_nf DO2_nf


Groupe1=[];
irrelevantF=[];
selected_features1=[];
data1=[traindata.X traindata.Y];
thawhdata=data1;

test=thetest;
X=traindata.X;
y=traindata.Y;

% configure parameters (I never change these)
start=tic;
wealth = 0.5;
delta_alpha = 0.5;
% n observations; p features
[n,p] = size(X);
% initially add constant term into the model
model = [1, zeros(1,p-1)];
error = Prediction_Error(X(:,model==1), y, Linear_Regression(X(:,model==1), y));
for i=2:p
    
    %if mod(i,1000)==0
    %i
    %end
    
    alpha = wealth/(2*i);
    %i
    %compute p_value
    %method one: derive delta(loglikelihood) from L2 error
    model(i) = 1;
    error_new = Prediction_Error(X(:,model==1), y, Linear_Regression(X(:,model==1), y));
    sigma2 = error/n;
    p_value = exp((error_new-error)/(2*sigma2));
    
    %method two: derive delta(loglikelihood) from t-statistic
    %model(i) = 1;
    %w = Linear_Regression(X(:,model==1), y);
    %sigma2 = Prediction_Error(X(:,model==1), y, w)/n;
    %EX = mean(X(:,model==1));
    %w_new_std = w(end)/sqrt(sigma2/(sum(sum((X(:,model==1)-ones(n,1)*EX).^2, 2))));
    %p_value = 2*(1-normcdf(abs(w_new_std), 0, 1));
    
    if p_value < alpha %feature i is accepted
        model(i) = 1;
        error = error_new;
        wealth = wealth + delta_alpha - alpha;
    else %feature i is discarded
        model(i) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if(strcmp(alg1,'PSO'))
            CI1=1;
            newfeaturerund=false;
            p1=length(irrelevantF);
            for j=1:p1
                %  irrelevantF(j)
                
                [CI1,dep1]=compter_dep_2(i,irrelevantF(j),p+1,3, 0, alpha, test,data1);
                
                if CI1==1 || isnan(dep1)
                    newfeaturerund=true;
                    break;
                else
                    newfeaturerund=false;
                    continue;
                end
                
            end
            if(newfeaturerund==false)
                disp('PSOFS1')
                [Groupe1]=PSOFS1(i); %data1,alpha,class_index
                %pause(20)
            end
            
        elseif(strcmp(alg1,'WD2O'))
            CI1=1;
            newfeaturerund=false;
            p1=length(irrelevantF);
            for j=1:p1
                %  irrelevantF(j)
                
                [CI1,dep1]=compter_dep_2(i,irrelevantF(j),p+1,3, 0, alpha, test,data1);
                
                if CI1==1 || isnan(dep1)
                    newfeaturerund=true;
                    break;
                else
                    newfeaturerund=false;
                    continue;
                end
                
            end
            if(newfeaturerund==false)
                disp('WD2OFS1')
                [Groupe1]=WD2OFS1(i,selected_features1); %data1,alpha,class_index
                %pause(20)
            end
            
            
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        wealth = wealth - alpha;
    end
end
% train final model
w = zeros(p,1);
w(model==1,1) = Linear_Regression(X(:,model==1), y);

time=toc(start);
f=find(model);
OFS_nf=f;
DO1_nf=irrelevantF([Groupe1]);
f=[f irrelevantF([Groupe1])];

% Linear_Regression
function [w] = Linear_Regression(X, y)
% this is not the most efficient way to find w!
w = inv(X'*X)*X'*y;
%w=regress(y,X);

% Prediction_Error
function [error] = Prediction_Error(X, y, w)
yhat = X*w;
error = sum((y-yhat).^2);
