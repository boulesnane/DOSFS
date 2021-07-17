function WD2O2Initialization1
global param nbrevolu th  iter1 maxiter1 swarm1 nPop dim1 VelMin VelMax VarMin VarMax sommeold bestold interV
%-------------------------------------------------------------

% User defined WDO parameters:
nPop = 5;		% population size.
dim1 = 0;			% Dimension of the problem.
maxiter1 = 50;		% Maximum number of iterations.
param.RT = 0.1;			% RT coefficient.
param.g = 0;			% gravitational constant.
param.alp = 0.01;		% constants in the update eq.
param.c = 1;			% coriolis effect.
th=0.5;
VarMin=0;
VarMax=1;
VelMax=0.1;
VelMin=-VelMax;
iter1=1;
VarSize=[1 dim1];
bestold=-Inf;
interV=VelMax;
nbrevolu=0;
sommeold=0;
%---------------------------------------------------------------
empty_particle.Position=[];
empty_particle.acc=-Inf;
empty_particle.pressure=1;
empty_particle.Velocity=[];
swarm1.particle=repmat(empty_particle,nPop,1);
swarm1.BestSol.acc=-Inf;
swarm1.BestSol.pressure=1;
swarm1.BestSol.Position=[];
swarm1.Bestacc=zeros(maxiter1,1);

for i=1:nPop
    
    % Initialize Position
    swarm1.particle(i).Position=unifrnd(VarMin,VarMax,VarSize);
    
    % Initialize Velocity
    swarm1.particle(i).Velocity=zeros(VarSize);
    
end

end