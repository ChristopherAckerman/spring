function [ff]=findeqhatalgebra(xvec)
global lambda0 Yshare0 Khat Lhat ssigma S
%xvec=exp(xvec);
% Gets the values from xvec
lambda_hat=xvec(S:end);
% Reshape so it is a SxS matrix 
lambda_hat=reshape(lambda_hat,S,S);
%Get the values for the change in wages
w_hat=[1;xvec(1:S-1)];
% Computing the change in Y
Y_hat=w_hat.*(Lhat');
% Equation 17 (S equations (One per row))
ff(:,1)=(Y_hat-...
sum(lambda0.*(ones(S,1)*Yshare0)./(Yshare0'*ones(1,S)).*...
lambda_hat.*((Y_hat*ones(1,S))'),2));
% Computing numerator and denominator in equation 22
Num=Khat.*(w_hat*ones(1,S)).^(1-ssigma);
Den=ones(S,1)*sum(lambda0.*Num,1);
% Equation 18 (Actually a matrix of SxS)
ff(:,2:S+1)=lambda_hat-Num./Den;
%ff=ff(1:end,:);
% Reshape so it is a vector
ff=reshape(ff,size(ff,1)*size(ff,2),1);
% One equation is a linear combination of the others, we disregard the
% first one
ff=ff(2:end);

end