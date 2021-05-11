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
M      = [300,300]             ;
ttheta = 10              ;
L      = [1,1]               ;                                          % Labor Supply
Tau    = [1,1.3;1.3,1]           ;                                      % Iceberg costs
fxc     = [1, 1.05; 1.05, 1]   ;                                          
ssigma = 6                 ;                                            % Elasticity of substitution
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
% Decrease in Icerberg Tradecosts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tau(1,2)    =  1.1                               ;
Tau(2,1)    =  Tau(1,2)    ;                      ;
w0          =  0.4                                 ;           
% Using fsolve to find the equilibrium wage 
w2          =  fsolve( @(x)findeq2countryMelitz(x),w0) ;
% Some useful calculations 
[model_end]=  modelcalculations2countryMelitz(w2)     ;
