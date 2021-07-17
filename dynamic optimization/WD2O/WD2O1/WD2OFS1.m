function [Groupe1]=WD2OFS1(newFeature,selected_features1)
global  th  iter1 maxiter1 irrelevantF  swarm1 dim1 theBCF bestold interV
Groupe1=[];
theBCF=selected_features1;
irrelevantF=[irrelevantF, newFeature];

if(dim1~=size(irrelevantF,2))
    WD2O2change_detection1;
    thesize=size(swarm1.Bestacc,1);
    cteur=0;
    while(iter1<maxiter1)
        
        WD2O2Update(swarm1,irrelevantF,dim1);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%Velocite intervalle%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if(bestold==swarm1.BestSol.acc)
            cteur=cteur+1;
        else
            cteur=0;
        end
        if(cteur==5)
            interV= interV/2;
            cteur=0;
        end
        bestold=swarm1.BestSol.acc;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        swarm1.Bestacc(thesize+iter1)=swarm1.BestSol.acc;
        %     selectedFeatures = find(BestSol.Position>th);
        %   disp(['iter1ation ' num2str(iter1) ': Best acc = ' num2str(Bestacc(iter1)) ': FeatIndex = ' mat2str(selectedFeatures)]);
        iter1=iter1+1;
    end
    iter1=1;
    Groupe1=find(swarm1.BestSol.Position>th);
    
    irrelevantF=irrelevantF([Groupe1]);
    dim1=length(irrelevantF);
    swarm1.BestSol.Position=swarm1.BestSol.Position(find(swarm1.BestSol.Position>th));
    
end
end