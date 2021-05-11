function [mod]=modelcalculations(wvec0)
global A S L Tau a_mat ssigma
wvec=[A(1,1),wvec0];
mod.Tech=A;
mod.Lab=L;
mod.Sigma=ssigma;
mod.amat=a_mat;
mod.iceberg=Tau;
mod.wages=wvec;
K=a_mat.*(Tau.^(1-ssigma)).*((ones(S,1)*A.^(ssigma-1))'); %expression of K_ij 
Num=K.*((ones(S,1)*(wvec).^(1-ssigma))'); % numerator of X_ij in eqn(13) in lecture
Den=sum(Num,1); % numerator of X_ij in eqn(13) 
Y=wvec.*L; % eqn (11)
mod.Y=Y;
mod.X=Num.*(ones(S,1)*Y)./sum(Num,1); %expression of X_ij in eqn(13)
mod.lambda=Num.*(ones(S,1))./sum(Num,1);
mod.prices=Tau.*(ones(S,1)*(wvec./A))'; % eqn (6) on p_ij in lecture
mod.P=sum((mod.prices.^(1-ssigma)).*a_mat,1).^(1/(1-ssigma)); % expression of aggregate Price
mod.q=mod.X./mod.prices;
mod.U=sum((a_mat.^(1/ssigma)).*(mod.q).^((ssigma-1)/ssigma),1).^(ssigma/(ssigma-1));
mod.K=K;
mod.L=L;
mod.Yshare=Y*(1/sum(Y,2));
mod.a_mat=a_mat;
mod.A=A;
end