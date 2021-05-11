%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            ARMINGTON MODEL

% 2021 Spring Econ 202 C, UCLA
% Chang He and Paula Beltran 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: In this file we have some numerical exercises on the
% Armington model from the Lecture Notes. 
% We start with the basic 2-country model. Then we expand then number of
% countries to 4.
% This script uses the following functions:
% 1) findeq2country:            This function is required to find the 
%                               equilibrium in the 2 country model
% 2) hatalgebra2country:        Hat algebra equations for 2-country model
% 3) modelcalculations2country: Computes additional measures in the model
%                               given wages
% 4) findeq: General code for S countries
% 5) findeqhatalgebra: Hat Algebra
% 6) modelcalculations: code to compute some statistics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
clc;
% Filling in the parameters
global A S L Tau a_mat ssigma
A      = [1,1.25]              ;                                            % Technology
L      = [15,14]               ;                                            % Labor Supply
Tau    = [1,1.2;1.2,1]         ;                                            % Iceberg costs
a_mat  = [0.8, 0.2; 0.1, 0.9]  ;                                            % Preference shares
ssigma = 5                     ;                                            % Elasticity of substitution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solving the initial equilibrium
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial value for the wage in the second country
% Note: My initial guess is the same wage as in country 1
w0          =  1                                 ;           
% Using fsolve to find the equilibrium wage 
w1          =  fsolve( @(x)findeq2country(x),w0) ;
% Some useful calculations 
[model_init]=  modelcalculations2country(w1)     ;
% Saving the initial iceberg costs
Tau0        =  Tau                               ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Counterfactual change in Iceberg trade costs  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tau(1,2)    =  1.6                               ;
Tau(2,1)    =  Tau(1,2)                          ;
% Finding the solution using the equilibrium conditions
w2          =  fsolve( @(x)findeq2country(x),w1) ;
[model_end] =  modelcalculations2country(w2)     ;


% Finding the changes using hat algebra
global Khat Lhat lambda0 Yshare0
Khat        = (Tau./Tau0).^(1-ssigma)                  ;
Lhat        = ones(size(L))                           ;
lambda0     = model_init.lambda                       ;
Yshare0     = model_init.Yshare                       ;
x0          = ones(5,1)                               ;
xvec        = fsolve( @(x)hatalgebra2country(x),x0)   ;
w_hat(1,1)  = 1                                       ;
w_hat(2,1)  = xvec(1)                                 ;
lambda_hat  = xvec(2:end)                             ;
lambda_hat  = reshape(lambda_hat,2,2)                 ;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4 Country model (Homework 1, Q1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARAMETERS
A      =  [1, .5, .5, .5];
S      =  size(A,2);
L      =  [1, 1, 1, 1];
Tau    =  [1 ,	1.3,	1.4,	1.2 ;...
          1.3,  1  ,    1.3,	1.2  ;...
          1.4,	1.4,	1  ,	1.3  ;...
          1.4,	1.4,	1.3,	1]   ;
a_mat  =  [1 ,	1,	1,	1; ...
           1,	1,	1,	1; ...
           1,	1,	1 ,	1; ...
           1,	1,	1,	1];
ssigma = 5;
% Finding Initial Equilibrium
winit=[1,1,1];
w0=fsolve(@(x)findeq(x),winit);
model_init=modelcalculations(w0);
% Finding Final equilibrium
Tau = [1, 1, 1, 1.2;...
    1, 1, 1.3, 1.2;...
    1, 1.4, 1, 1.3;...
    1, 1.4, 1.3, 1];
w0=fsolve(@(x)findeq(x),w0);
model_final=modelcalculations(w0);
% Hat algebra
% Some initial steps
global lambda0 Yshare0 Khat Lhat
L0=model_init.L;
L1=L;
A0=model_init.A;
A1=[1, .5, .5, .5];
Tau0=model_init.iceberg;
Tau1=Tau;
a_mat0=model_init.a_mat;
a_mat1=a_mat;
K0=model_init.K;
K1=(a_mat1.*(Tau1.^(1-ssigma))).*((ones(S,1)*A1.^(ssigma-1))');
Yshare0=model_init.Yshare;
lambda0=model_init.lambda;
Khat=K1./K0;
Lhat=L1./L0;
% Initial values
x0=[model_init.wages(1:end-1)*0+1,reshape(lambda0,1,S*S)*0+1];
% Finding the solution
xsol=fsolve(@(x) findeqhatalgebra(x),x0');
lambda_hat=xsol(S:end);
lambda_hat=reshape(lambda_hat,S,S);
w_hat=[1;xsol(1:S-1)];
% check that hat algebra gives the same solution as direct calculation
model_final.wages./model_init.wages

