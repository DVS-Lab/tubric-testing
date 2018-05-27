% Fit Naive reinforcement learning model to individual data

% ------------ fit models --------------------%

% create parameter structure
g = [2 3];  % parameters of the gamma prior
param(1).name = 'inverse temperature';
param(1).logpdf = @(x) sum(log(gampdf(x,g(1),g(2))));  % log density function for prior
param(1).lb = 0;    % lower bound
param(1).ub = 50;   % upper bound

a = 1.2; b = 1.2;   % parameters of beta prior
param(2).name = 'learning rate';
param(2).logpdf = @(x) sum(log(betapdf(x,a,b)));
param(2).lb = 0;
param(2).ub = 1;


% run optimization
nstarts = 6;    % number of random parameter initializations

%%
disp('... Fitting RW');
results = mfit_optimize(@RW,param(1:2),data_fit,nstarts);
