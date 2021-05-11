%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            MELITZ MODEL
%  Chang He
%  April, 14, 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: In this file we have some numerical exercises on the
% Melitz model from the Lecture Notes. 
% We start with the basic 2-country model. 
% This script uses the following functions:
% 1) findeq2country:            This function is required to find the 
%                               equilibrium in the 2 country model
% 2) modelcalculations2country: Computes additional measures in the model
%                               given wages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
% Filling in the parameters
global ttheta L Tau  ssigma fxc M;
M      = [100,100]             ;
ttheta = 5              ;
L      = [1,1]               ;                                          % Labor Supply
Tau    = [1,1.2;1.2,1]           ;                                      % Iceberg costs
fxc     = [0.7, 0.9; 0.9, 0.7]   ;                                          
ssigma = 4                 ;                                            % Elasticity of substitution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solving the initial equilibrium
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial value for the wage in the second country
% Note: My initial guess is the same wage as in country 1
w0          =  0.4                                 ;           
% Using fsolve to find the equilibrium wage 
w2          =  fsolve( @(x)findeq2countryMelitz(x),w0) ;
% Some useful calculations 
[model_init]=  modelcalculations2countryMelitz(w2)     ;
% Saving the initial iceberg costs
Tau0        =  Tau    ;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Decrease in Icerberg Tradecosts/export costs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tau(1,2)    =  1.2                               ;
Tau(2,1)    =  Tau(1,2)    ;                      ;
fxc     = [0.7, 0.8; 0.8, 0.7]   ;  
w0          =  0.4                                 ;           
% Using fsolve to find the equilibrium wage 
w2          =  fsolve( @(x)findeq2countryMelitz(x),w0) ;
% Some useful calculations 
[model_end]=  modelcalculations2countryMelitz(w2)     ;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hat Algebra %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global lambda0 Yshare0 Khat Lhat
S = 2;
Tau1= [1,1.1;1.1,1];
K0=model_init.K;
%K1=;
Yshare0=model_init.Yshare;
lambda0=model_init.lambda;
Khat=K0./K0;
Lhat=1;
% Initial values
x0=1;
% Finding the solution
w_hat=model_init.wages;
lambda_hat=model_init.lambda;
xsol=fsolve(@(x) hatalgebra2countryMelitz(x),x0');
% lambda_hat=xsol(S:end);
% lambda_hat=reshape(lambda_hat,S,S);
% w_hat=[1;xsol(1:S-1)];