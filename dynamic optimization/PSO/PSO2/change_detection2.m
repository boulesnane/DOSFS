function change_detection2


global  swarm2 nPop  VelMin VelMax VarMin VarMax dim2 redundantF
%dim2=dim2+1;
dim2=length(redundantF);
VarSize=[1 dim2];
swarm2.BestSol.Position=[swarm2.BestSol.Position randvalue(0,0.5)];
for i=1:nPop
    
    % Initialize Position
    swarm2.particle(i).Position=unifrnd(VarMin,VarMax,VarSize);
    
    % Initialize Velocity
    swarm2.particle(i).Velocity=unifrnd(VelMin,VelMax,VarSize);
    
    % Evaluation
    
    [swarm2.particle(i).acc] = evaluer(swarm2.particle(i).Position,redundantF);
    
    % Update Personal Best
    swarm2.particle(i).Best.Position=swarm2.particle(i).Position;
    swarm2.particle(i).Best.acc=swarm2.particle(i).acc;
    
    
    % Update Global Best
    %[swarm2.BestSol.acc] = evaluer(swarm2.BestSol.Position);
    
    if swarm2.particle(i).Best.acc>swarm2.BestSol.acc
        
        swarm2.BestSol=swarm2.particle(i).Best;
        
    end
    
end


end