function [Groupe1]=PSOFS1(newFeature)


global  th   iter1 maxiter1  dim1  irrelevantF  swarm1

% irrelevantF=[irrelevantF, newFeature];
%   p2=length(irrelevantF);
%           selected_features1=irrelevantF;
%
%            for j=1:p2
%
%               b=setdiff(selected_features1, irrelevantF(j),'stable');
%
%                if ~isempty(b)
%                    b
%                    irrelevantF(j)
%                   [CI,dep]=compter_dep_2(b,irrelevantF(j),class_index,3, 0, alpha, 'z',data1);
%
%
%                    if CI==1 || isnan(dep)
%                       selected_features1=b;
%                    end
%               end
%            end
%  irrelevantF=selected_features1;
irrelevantF=[irrelevantF, newFeature];
if(dim1~=size(irrelevantF,2))
    start=tic;
    change_detection1;
    noro1=toc(start)
    start3=tic;
    
    while(iter1<maxiter1)
        Update(swarm1,irrelevantF);
        
        swarm1.Bestacc(iter1)=swarm1.BestSol.acc;
        %     selectedFeatures = find(BestSol.Position>th);
        %   disp(['iter1ation ' num2str(iter1) ': Best acc = ' num2str(Bestacc(iter1)) ': FeatIndex = ' mat2str(selectedFeatures)]);
        iter1=iter1+1;
    end
    noro3=toc(start3)
    
    iter1=1;
end
Groupe1=find(swarm1.BestSol.Position>th);
end
