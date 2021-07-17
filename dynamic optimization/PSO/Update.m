function Update(swarm,features)

global nPop  w c1 c2  VelMin VelMax VarMin VarMax

for i=1:nPop
    
    % Update Velocity
    
    swarm.particle(i).Velocity = w*swarm.particle(i).Velocity ...
        +c1*rand.*(swarm.particle(i).Best.Position-swarm.particle(i).Position) ...
        +c2*rand.*(swarm.BestSol.Position-swarm.particle(i).Position);
    
    % Apply Velocity Limits
    swarm.particle(i).Velocity = max(swarm.particle(i).Velocity,VelMin);
    swarm.particle(i).Velocity = min(swarm.particle(i).Velocity,VelMax);
    
    % Update Position
    swarm.particle(i).Position = swarm.particle(i).Position + swarm.particle(i).Velocity;
    
    
    % Apply Position Limits
    swarm.particle(i).Position = max(swarm.particle(i).Position,VarMin);
    swarm.particle(i).Position = min(swarm.particle(i).Position,VarMax);
    
    % Evaluation
    [swarm.particle(i).acc] = evaluer(swarm.particle(i).Position,features);
    
    % Update Personal Best
    if swarm.particle(i).acc>swarm.particle(i).Best.acc
        
        swarm.particle(i).Best.Position=swarm.particle(i).Position;
        swarm.particle(i).Best.acc=swarm.particle(i).acc;
        
        % Update Global Best
        if swarm.particle(i).Best.acc>swarm.BestSol.acc
            
            swarm.BestSol=swarm.particle(i).Best;
            
        end
        
    end
    
end

end