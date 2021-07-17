function pressure(swarm,dim)
global   nPop  sommeold param interV VelMax
fitness=[];
for j=1:(nPop)
    fitness=[fitness swarm.particle(j).acc];
end

somme=0;
for j=1:(nPop)
    somme=somme+(swarm.particle(j).acc-min(min(fitness),swarm.BestSol.acc));
end
somme=somme+(swarm.BestSol.acc-min(min(fitness),swarm.BestSol.acc));

if(sommeold==somme || somme==0)  %abs((valuebestfitness-max(max(fitness),valuebestfitness)))<0.0001
    param.g=rand;
    interV=VelMax;
else
    for j=1:(nPop)
        swarm.particle(j).pressure=exp(-dim*((swarm.particle(j).acc-min(min(fitness),swarm.BestSol.acc))/somme));
    end
    swarm.BestSol.pressure=exp(-dim*((swarm.BestSol.acc-min(min(fitness),swarm.BestSol.acc))/somme));
end
sommeold=somme;

end

