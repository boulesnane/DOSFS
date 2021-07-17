function WD2O2Update(swarm,features,dim)

global param nPop VelMin VelMax VarMin VarMax interV

for i=1:nPop
    
    % Update Velocity
    
    % choose random dimensions:
    a = randperm(dim);
    % choose velocity based on random dimension:
    velot(i,:) = swarm.particle(i).Velocity(a);
    %             swarm.particle(i).Velocity
    %             swarm.particle(i).Position
    %             swarm.BestSol.Position
    swarm.particle(i).Velocity= (1-param.alp)*swarm.particle(i).Velocity-(param.g*swarm.particle(i).Position)+ ...
        abs(1-swarm.BestSol.pressure/swarm.particle(i).pressure)*((swarm.BestSol.Position-swarm.particle(i).Position).*param.RT)+ ...
        (param.c*velot(i,:)/swarm.particle(i).pressure);
    
    % Apply Velocity Limits
    swarm.particle(i).Velocity = max(swarm.particle(i).Velocity,-interV);
    swarm.particle(i).Velocity = min(swarm.particle(i).Velocity,interV);
    
    % Update Position
    swarm.particle(i).Position = swarm.particle(i).Position + swarm.particle(i).Velocity;
    
    
    % Apply Position Limits
    swarm.particle(i).Position = max(swarm.particle(i).Position,VarMin);
    swarm.particle(i).Position = min(swarm.particle(i).Position,VarMax);
    
    % Evaluation
    [swarm.particle(i).acc] = evaluer(swarm.particle(i).Position,features);
    pressure(swarm,dim);
    
    if swarm.particle(i).acc>swarm.BestSol.acc
        swarm.BestSol.acc=swarm.particle(i).acc;
        swarm.BestSol.pressure=swarm.particle(i).pressure;
        swarm.BestSol.Position=swarm.particle(i).Position;
    end
    
    
end



end