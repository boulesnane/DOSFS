function WD2O2Initialization2
global param nbrevolu th  iter2 maxiter2 swarm2 nPop dim2 VelMin VelMax VarMin VarMax sommeold bestold interV
%-------------------------------------------------------------

% User defined WDO parameters:
nPop = 5;		% population size.
dim2 = 0;			% Dimension of the problem.
maxiter2 = 100;		% Maximum number of iterations.
param.RT = 0.1;			% RT coefficient.
param.g = 0;			% gravitational constant.
param.alp = 0.01;		% constants in the update eq.
param.c = 1;			% coriolis effect.
th=0.5;
VarMin=0;
VarMax=1;
VelMax=0.1;
VelMin=-VelMax;
iter2=1;
VarSize=[1 dim2];
bestold=-Inf;
interV=VelMax;
nbrevolu=0;
sommeold=0;
rng(1);
%---------------------------------------------------------------
empty_particle.Position=[];
empty_particle.acc=-Inf;
empty_particle.pressure=1;
empty_particle.Velocity=[];
swarm2.particle=repmat(empty_particle,nPop,1);
swarm2.BestSol.acc=-Inf;
swarm2.BestSol.pressure=1;
swarm2.BestSol.Position=[];
swarm2.Bestacc=zeros(maxiter2,1);

for i=1:nPop
    
    % Initialize Position
    swarm2.particle(i).Position=unifrnd(VarMin,VarMax,VarSize);
    
    % Initialize Velocity
    swarm2.particle(i).Velocity=zeros(VarSize);
    
end

end