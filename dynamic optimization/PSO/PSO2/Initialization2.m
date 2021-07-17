function Initialization2


global  th  iter2 maxiter2 swarm2 nPop dim2  w c1 c2  VelMin VelMax VarMin VarMax

nPop=5;
VarMin=0;
VarMax=1;
dim2=0;
VarSize=[1 dim2];
iter2=1;
maxiter2=100;
w=0.7298;
c1=1.49618;
c2=1.49618;
th=0.5;
VelMax=0.1*(VarMax-VarMin);
VelMin=-VelMax;
rng(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Initialize
empty_particle.Position=[];
empty_particle.acc=[];
empty_particle.Velocity=[];
empty_particle.Best.Position=[];
empty_particle.Best.acc=[];
swarm2.particle=repmat(empty_particle,nPop,1);
swarm2.BestSol.acc=-inf;
swarm2.BestSol.Position=[];
swarm2.Bestacc=zeros(maxiter2,1);
for i=1:nPop
    
    % Initialize Position
    swarm2.particle(i).Position=unifrnd(VarMin,VarMax,VarSize);
    
    % Initialize Velocity
    swarm2.particle(i).Velocity=zeros(VarSize);
    
end


end