function change_detection1


global  swarm1 nPop  VelMin VelMax VarMin VarMax dim1 irrelevantF
dim1=dim1+1;
VarSize=[1 dim1];
swarm1.BestSol.Position=[swarm1.BestSol.Position randvalue(0,0.5)];
for i=1:nPop
    
    % Initialize Position
    swarm1.particle(i).Position=unifrnd(VarMin,VarMax,VarSize);
    
    % Initialize Velocity
    swarm1.particle(i).Velocity=unifrnd(VelMin,VelMax,VarSize);
    
    
    % Evaluation
    start2=tic;
    [swarm1.particle(i).acc] = evaluer(swarm1.particle(i).Position,irrelevantF);
    noro2=toc(start2)
    
    % Update Personal Best
    swarm1.particle(i).Best.Position=swarm1.particle(i).Position;
    swarm1.particle(i).Best.acc=swarm1.particle(i).acc;
    
    
    % Update Global Best
    %[swarm1.BestSol.acc] = evaluer(swarm1.BestSol.Position);
    
    if swarm1.particle(i).Best.acc>swarm1.BestSol.acc
        
        swarm1.BestSol=swarm1.particle(i).Best;
        
    end
    
end


end