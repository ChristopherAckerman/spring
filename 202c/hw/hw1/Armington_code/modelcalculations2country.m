function [model]=modelcalculations2country(w0)
global A  L Tau a_mat ssigma
% Fill in wages
w=[A(1,1),w0];
% Computing Output
Y=w.*L;
% Fill in K 
for i=1:2
    for j=1:2
        K(i,j)=a_mat(i,j)*Tau(i,j)^(1-ssigma)*A(i)^(ssigma-1);
    end
end
% Fill in numerator and denominator
for j=1:2
    for i=1:2
       Nume(i,j)= K(i,j)*w(i)^(1-ssigma);
    end
    Deno(j)=sum(Nume(:,j),1);
    for i=1:2
       lambda(i,j)= Nume(i,j)/Deno(j);
       X(i,j)     = lambda(i,j)*Y(j);
    end
end
Yshares=Y*(1/sum(Y));
% Saving results in structure
model.Y=Y;
model.Yshare=Yshares;
model.lambda=lambda;
model.X=X;
model.wages=w;
model.K=K;
end