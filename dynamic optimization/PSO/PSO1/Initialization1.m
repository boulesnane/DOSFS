function Initialization1


global Data th BestSol dim1 iter1 maxiter1 swarm1 nPop testdata  traindata class_index Bestacc  w c1 c2  VelMin VelMax VarMin VarMax

nPop=30;
VarMin=0;
VarMax=1;
dim1=1;
VarSize=[1 dim1];
iter1=1;
maxiter1=100;
w=0.729844;
c1=2.05;
c2=2.05;
th=0.5;
VelMax=0.1*(VarMax-VarMin);
VelMin=-VelMax;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Initialize
empty_particle.Position=[];
empty_particle.acc=[];
empty_particle.Velocity=[];
empty_particle.Best.Position=[];
empty_particle.Best.acc=[];
swarm1.particle=repmat(empty_particle,nPop,1);
swarm1.BestSol.acc=-inf;
swarm1.BestSol.Position=[];
swarm1.Bestacc=zeros(maxiter1,1);
for i=1:nPop
    
    % Initialize Position
    swarm1.particle(i).Position=unifrnd(VarMin,VarMax,VarSize);
    
    % Initialize Velocity
    swarm1.particle(i).Velocity=zeros(VarSize);
    
end


end