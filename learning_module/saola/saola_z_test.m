function [current_feature,time] = saola_z_test(alg1,alg2)
global  traindata thetest alpha redundantF irrelevantF thawhdata threshold OFS_nf DO1_nf DO2_nf


%input
%Performs the SAOLA algorithm using mutual information measure by Yu 2014.
%data: columns denote features (attributes), while rows represent data instances.
%the last column of a data set is the class attribute

%output
%current_feature: selected features
%time: running time
Groupe1=[];
Groupe2=[];
irrelevantF=[];
redundantF=[];
data=[traindata.X traindata.Y];
thawhdata=data;
test=thetest;

start_time=tic;
[n,numFeatures] = size(data);

class_a=numFeatures;%the index of the class attribute
selected_features1=[];
current_feature=[];
dep=sparse(1,numFeatures-1);

CI=1;


for i = 1:numFeatures-1
    
    
    %for very sparse data
    n1=sum(data(:,i));
    if n1==0
        continue;
    end
    
    
    
    [CI,dep(i)] = my_cond_indep_fisher_z(data,i, class_a, [],n,alpha);
    
    
    if CI==1 || isnan(dep(i))
        if(strcmp(alg1,'PSO'))
            CI1=1;
            newfeaturerund=false;
            p1=length(irrelevantF);
            for j=1:p1
                %  irrelevantF(j)
                i
                [CI1,dep1]=compter_dep_2(i,irrelevantF(j),class_a,3, 0, alpha, test,data);
                
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
                i
                [CI1,dep1]=compter_dep_2(i,irrelevantF(j),class_a,3, 0, alpha, test,data);
                
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
        continue;
    end
    
    current_feature=[current_feature, i];
    
    %current_feature1=setdiff(current_feature,i,'stable');
    current_feature1=current_feature(~sum(bsxfun(@eq,current_feature',i),2));
    
    if ~isempty(current_feature1)
        
        p=length(current_feature1);
        
        for j=1:p
            
            
            [CI, dep_ij] = my_cond_indep_fisher_z(data,i, current_feature1(j), [],n,alpha);
            
            if CI==1|| isnan(dep_ij)
                continue;
            end
            
            t_dep=dep_ij;
            t_feature=current_feature1(j);
            
            if dep(t_feature)>=dep(i) && t_dep>dep(i)
                
                %current_feature=setdiff(current_feature,i, 'stable');
                current_feature=current_feature(~sum(bsxfun(@eq,current_feature',i),2));
                break;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if(strcmp(alg2,'PSO'))
                    newfeaturerund=false;
                    p3=length(redundantF);
                    for z=1:p3
                        % irrelevantF(j)
                        [CI2,dep2]=compter_dep_2(i,redundantF(z),class_a,3, 0, alpha, test,data);
                        if CI2==1 || isnan(dep2)
                            newfeaturerund=true;
                            break;
                        else
                            newfeaturerund=false;
                            continue;
                        end
                    end
                    if(newfeaturerund==false)
                        disp('PSOFS2')
                        [Groupe2]=PSOFS2(i);
                    end
                    
                elseif(strcmp(alg2,'WD2O'))
                    newfeaturerund=false;
                    p3=length(redundantF);
                    for z=1:p3
                        % irrelevantF(j)
                        [CI2,dep2]=compter_dep_2(i,redundantF(z),class_a,3, 0, alpha, test,data);
                        if CI2==1 || isnan(dep2)
                            newfeaturerund=true;
                            break;
                        else
                            newfeaturerund=false;
                            continue;
                        end
                    end
                    if(newfeaturerund==false)
                        disp('WD2OFS2')
                        [Groupe2]=WD2OFS2(i);
                    end
                    
                    
                    
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            end
            
            if dep(i)>dep(t_feature) && t_dep>dep(t_feature)
                
                current_feature=current_feature(~sum(bsxfun(@eq,current_feature',t_feature),2));
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if(strcmp(alg2,'PSO'))
                    newfeaturerund=false;
                    p3=length(redundantF);
                    for z=1:p3
                        % irrelevantF(j)
                        [CI2,dep2]=compter_dep_2(t_feature,redundantF(z),class_a,3, 0, alpha, test,data);
                        if CI2==1 || isnan(dep2)
                            newfeaturerund=true;
                            break;
                        else
                            newfeaturerund=false;
                            continue;
                        end
                    end
                    if(newfeaturerund==false)
                        disp('PSOFS2')
                        [Groupe2]=PSOFS2(t_feature);
                    end
                    
                elseif(strcmp(alg2,'WD2O'))
                    newfeaturerund=false;
                    p3=length(redundantF);
                    for z=1:p3
                        % irrelevantF(j)
                        [CI2,dep2]=compter_dep_2(t_feature,redundantF(z),class_a,3, 0, alpha, test,data);
                        if CI2==1 || isnan(dep2)
                            newfeaturerund=true;
                            break;
                        else
                            newfeaturerund=false;
                            continue;
                        end
                    end
                    if(newfeaturerund==false)
                        disp('WD2OFS2')
                        [Groupe2]=WD2OFS2(t_feature);
                    end
                    
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            end
            
            
        end
        
    end
    
end

time=toc(start_time);

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
current_feature
OFS_nf=current_feature;
DO1_nf=irrelevantF([Groupe1]);
DO2_nf=redundantF([Groupe2]);
current_feature=[current_feature irrelevantF([Groupe1]) redundantF([Groupe2])];
disp('irrelevantF')
irrelevantF([Groupe1])
disp('redundantF')
redundantF([Groupe2])
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

