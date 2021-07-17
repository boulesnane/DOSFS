function WD2O2change_detection2


global  swarm2 nPop  VelMin VelMax VarMin VarMax dim2 redundantF interV
%dim2=dim2+1;
interV=VelMax;
dim2=length(redundantF);
VarSize=[1 dim2];
swarm2.BestSol.Position=[swarm2.BestSol.Position randvalue(0,0.5)];
for i=1:nPop
    swarm2.particle(i).Position=[];
    swarm2.particle(i).acc=-Inf;
    swarm2.particle(i).pressure=1;
    swarm2.particle(i).Velocity=[];
    
    swarm2.particle(i).Position=unifrnd(VarMin,VarMax,VarSize);
    swarm2.particle(i).Velocity=unifrnd(VelMin,VelMax,VarSize);
    
    % Evaluation
    [swarm2.particle(i).acc] = evaluer(swarm2.particle(i).Position,redundantF);
    
    if swarm2.particle(i).acc>swarm2.BestSol.acc
        swarm2.BestSol.acc=swarm2.particle(i).acc;
        swarm2.BestSol.Position=swarm2.particle(i).Position;
    end
    pressure(swarm2,dim2);
    
end


end