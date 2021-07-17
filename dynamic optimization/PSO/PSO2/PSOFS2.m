function [Groupe2]=PSOFS2(newFeature)


global  th BestSol  iter2 maxiter2 redundantF  swarm2 dim2 theBCF
Groupe2=[];

redundantF=[redundantF, newFeature];

if(dim2~=size(redundantF,2))
    change_detection2;
    thesize=size(swarm2.Bestacc,1);
    while(iter2<maxiter2)
        
        Update(swarm2,redundantF);
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