function   [selected_features, time]=osfs_z(alg1,alg2)
% for continue value
global alpha redundantF irrelevantF traindata  thawhdata thetest OFS_nf DO1_nf DO2_nf
seuil_red=0.5;
Groupe1=[];
Groupe2=[];
irrelevantF=[];
redundantF=[];
data1=[traindata.X traindata.Y];
[n,p]=size(data1);
class_index=p;
% DATAall.X=data1(:,1:(class_index-1));
% DATAall.Y=data1(:,class_index);
thawhdata=data1;
test=thetest;

ns=max(data1);
selected_features=[];
selected_features1=[];
b=[];
Groupe1=[];
Groupe2=[];

start=tic;

for i=1:p-1
    
    %     i
    %for very sparse data
    n1=sum(data1(:,i));
    if n1==0
        continue;
    end
    
    
    stop=0;
    CI=1;
    
    [CI,dep]=my_cond_indep_fisher_z(data1,i,class_index,[],n,alpha);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if CI==1 || isnan(dep) %irrelevant
        if(strcmp(alg1,'PSO'))
            newfeaturerund=false;
            i
            p3=length(irrelevantF)
            for z=1:p3
                % irrelevantF(j)
                [CI2,dep2]=compter_dep_2(i,irrelevantF(z),class_index,3, 0, alpha, test,data1);
                if CI2==1 || isnan(dep2)
                    newfeaturerund=true;
                    break;
                else
                    newfeaturerund=false;
                    continue;
                end
            end
            if(newfeaturerund==false)
                disp('PSOFS1')
                [Groupe1]=PSOFS1(i);
            end
        elseif(strcmp(alg1,'WD2O'))
            newfeaturerund=false;
            i
            p3=length(irrelevantF)
            for z=1:p3
                % irrelevantF(j)
                [CI2,dep2]=compter_dep_2(i,irrelevantF(z),class_index,3, 0, alpha, test,data1);
                if CI2==1 || isnan(dep2)
                    newfeaturerund=true;
                    break;
                else
                    newfeaturerund=false;
                    continue;
                end
            end
            if(newfeaturerund==false)
                disp('WD2OFS1')
                [Groupe1]=WD2OFS1(i,selected_features1);
            end
        end
        continue;
    end % CI==1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if CI==0
        stop=1;
        selected_features=[selected_features,i];
    end
    
    
    if stop
        
        p2=length(selected_features);
        selected_features1=selected_features;
        
        for j=1:p2
            
            b=setdiff(selected_features1, selected_features(j),'stable');
            
            if ~isempty(b)
                [CI,dep]=compter_dep_2(b,selected_features(j),class_index,3, 0, alpha, test,data1);
                
                
                if CI==1 || isnan(dep)
                    selected_features1=b;
                    
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    if(strcmp(alg2,'PSO'))
                        newfeaturerund=false;
                        i
                        p3=length(redundantF)
                        for z=1:p3
                            % irrelevantF(j)
                            [CI2,dep2]=compter_dep_2(selected_features(j),redundantF(z),class_index,3, 0, alpha, test,data1);
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
                            [Groupe2]=PSOFS2(selected_features(j));
                        end
                    elseif(strcmp(alg2,'WD2O'))
                        newfeaturerund=false;
                        i
                        p3=length(redundantF)
                        for z=1:p3
                            % irrelevantF(j)
                            [CI2,dep2]=compter_dep_2(selected_features(j),redundantF(z),class_index,3, 0, alpha, test,data1);
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
                            [Groupe2]=WD2OFS2(selected_features(j));
                        end
                    end
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                end
            end
        end
    end
    
    selected_features=selected_features1;
end

time=toc(start);
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
selected_features
Groupe2
OFS_nf=selected_features;
DO1_nf=irrelevantF([Groupe1]);
DO2_nf=redundantF([Groupe2]);
selected_features=[selected_features irrelevantF([Groupe1]) redundantF([Groupe2])];
disp('irrelevantF')
irrelevantF([Groupe1])
disp('redundantF')
redundantF([Groupe2])
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

