function [Groupe2]=WD2OFS2(newFeature)
global  th  iter2 maxiter2 redundantF  swarm2 dim2 theBCF bestold interV
Groupe2=[];

redundantF=[redundantF, newFeature];

if(dim2~=size(redundantF,2))
    WD2O2change_detection2;
    thesize=size(swarm2.Bestacc,1);
    cteur=0;
    while(iter2<maxiter2)
        
        WD2O2Update(swarm2,redundantF,dim2);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%Velocite intervalle%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if(bestold==swarm2.BestSol.acc)
            cteur=cteur+1;
        else
            cteur=0;
        end
        if(cteur==5)
            interV= interV/2;
            cteur=0;
        end
        bestold=swarm2.BestSol.acc;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        swarm2.Bestacc(thesize+iter2)=swarm2.BestSol.acc;
        %     selectedFeatures = find(BestSol.Position>th);
        %   disp(['iter2ation ' num2str(iter2) ': Best acc = ' num2str(Bestacc(iter2)) ': FeatIndex = ' mat2str(selectedFeatures)]);
        iter2=iter2+1;
    end
    iter2=1;
    Groupe2=find(swarm2.BestSol.Position>th);
    
    redundantF=redundantF([Groupe2]);
    dim2=length(redundantF);
    Groupe2=[1:dim2];
    swarm2.BestSol.Position=swarm2.BestSol.Position(find(swarm2.BestSol.Position>th));
    
end
end