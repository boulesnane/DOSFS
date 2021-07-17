function WD2O2change_detection1


global  swarm1 nPop  VelMin VelMax VarMin VarMax dim1 irrelevantF interV
%dim1=dim1+1;
interV=VelMax;
dim1=length(irrelevantF);
VarSize=[1 dim1];
swarm1.BestSol.Position=[swarm1.BestSol.Position randvalue(0,0.5)];
for i=1:nPop
    swarm1.particle(i).Position=[];
    swarm1.particle(i).acc=-Inf;
    swarm1.particle(i).pressure=1;
    swarm1.particle(i).Velocity=[];
    
    swarm1.particle(i).Position=unifrnd(VarMin,VarMax,VarSize);
    swarm1.particle(i).Velocity=unifrnd(VelMin,VelMax,VarSize);
    
    % Evaluation
    [swarm1.particle(i).acc] = evaluer(swarm1.particle(i).Position,irrelevantF);
    
    if swarm1.particle(i).acc>swarm1.BestSol.acc
        swarm1.BestSol.acc=swarm1.particle(i).acc;
        swarm1.BestSol.Position=swarm1.particle(i).Position;
    end
    pressure(swarm1,dim1);
    
end


end