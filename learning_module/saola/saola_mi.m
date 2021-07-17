function [current_feature,time] = saola_mi(alg1,alg2)
global  traindata thetest alpha redundantF irrelevantF thawhdata threshold OFS_nf DO1_nf DO2_nf


Groupe1=[];
Groupe2=[];
irrelevantF=[];
redundantF=[];
data=[traindata.X traindata.Y];
thawhdata=data;
test=thetest;
%input
%Performs the SAOLA algorithm using mutual information measure by Yu 2014.
%data: columns denote features (attributes), while rows represent data
%instances. if data is the sparse format, please using full(data)
%the last column of a data set is the class attribute

%output
%current_feature: selected features
%time: running time



start=tic;

numFeatures = size(data,2);

class_a=numFeatures;%the index of the class attribute
selected_features1=[];
current_feature=[];

dep=sparse(1,numFeatures-1);

for i = 1:numFeatures-1
    
    %for very sparse data
    n1=sum(data(:,i));
    if n1==0
        continue;
    end
    
    
    
    [dep(i)] = SU(data(:,i),data(:,class_a));
    
    if dep(i)<=threshold  %irrelevant
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if(strcmp(alg1,'PSO'))
            CI1=1;
            newfeaturerund=false;
            p1=length(irrelevantF);
            for j=1:p1
                %  irrelevantF(j)
                
                [CI1]=compter_dep_2(i,irrelevantF(j),class_a,3, 1, alpha, test,data);
                
                if CI1==1
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
                
                [CI1]=compter_dep_2(i,irrelevantF(j),class_a,3, 1, alpha, test,data);
                
                if CI1==1
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
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        continue;
    end
    
    current_feature=[current_feature, i];
    
    %current_feature1=setdiff(current_feature,i,'stable');
    current_feature1=current_feature(~sum(bsxfun(@eq,current_feature',i),2));
    
    if ~isempty(current_feature1)
        
        p=length(current_feature1);
        
        for j=1:p
            
            [dep_ij] = SU(data(:,i),data(:,current_feature1(j)));
            
            if dep_ij<=threshold
                continue;
            end
            
            max_dep=dep_ij;
            max_feature=current_feature1(j);
            
            if dep(max_feature)>dep(i) && max_dep>dep(i)
                
                %current_feature=setdiff(current_feature,i, 'stable');
                current_feature=current_feature(~sum(bsxfun(@eq,current_feature',i),2));
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if(strcmp(alg2,'PSO'))
                    newfeaturerund=false;
                    p3=length(redundantF);
                    for z=1:p3
                        % irrelevantF(j)
                        [CI2]=compter_dep_2(i,redundantF(z),class_a,3, 1, alpha, test,data);
                        if CI2==1
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
                        [CI2]=compter_dep_2(i,redundantF(z),class_a,3, 1, alpha, test,data);
                        if CI2==1
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
                break;
            end
            
            if dep(i)>dep(max_feature) && max_dep>dep(max_feature)
                
                %current_feature=setdiff(current_feature,max_feature, 'stable');
                current_feature=current_feature(~sum(bsxfun(@eq,current_feature',max_feature),2));
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if(strcmp(alg2,'PSO'))
                    newfeaturerund=false;
                    p3=length(redundantF);
                    for z=1:p3
                        % irrelevantF(j)
                        [CI2]=compter_dep_2(max_feature,redundantF(z),class_a,3, 1, alpha, test,data);
                        if CI2==1
                            newfeaturerund=true;
                            break;
                        else
                            newfeaturerund=false;
                            continue;
                        end
                    end
                    if(newfeaturerund==false)
                        disp('PSOFS2')
                        [Groupe2]=PSOFS2(max_feature);
                    end
                    
                elseif(strcmp(alg2,'WD2O'))
                    newfeaturerund=false;
                    p3=length(redundantF);
                    for z=1:p3
                        % irrelevantF(j)
                        [CI2]=compter_dep_2(max_feature,redundantF(z),class_a,3, 1, alpha, test,data);
                        if CI2==1
                            newfeaturerund=true;
                            break;
                        else
                            newfeaturerund=false;
                            continue;
                        end
                    end
                    if(newfeaturerund==false)
                        disp('WD2OFS2')
                        [Groupe2]=WD2OFS2(max_feature);
                    end
                end
            end
            
        end
        
    end
end

time=toc(start);
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



