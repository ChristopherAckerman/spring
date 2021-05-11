function [model]=modelcalculations2countryMelitz(w0)
global   L Tau  ssigma ttheta fxc M
% Fill in wages
w=[1,w0];
% Computing Output

C1= ssigma^(1-ttheta/(ssigma-1))*(ssigma/(ssigma-1))^(-ttheta)*(ttheta/(ttheta+1-ssigma));
C2= ssigma^(-ttheta/(ssigma-1))*(ssigma/(ssigma-1))^(-ttheta);
C3= (ssigma-1)/ssigma+C2/C1;
Y=w.*L/C3;

% Fill in K 
w=[1,w0];
% Fill in K 
for i=1:2
    kkappa(i)=(C1*C3^(1-ttheta/(ssigma-1))...
        *fxc(i,i)^(1-ttheta/(ssigma-1))*M(i)...
        *L(i)^(ttheta/(ssigma-1)-1))^(1/ttheta);
    for j=1:2
        K(i,j)=M(i)*Tau(i,j)^(-ttheta)*fxc(i,j)^(1-ttheta/(ssigma-1));
    end
end
% Fill in numerator and denominator
for j=1:2
    for i=1:2
       Nume(i,j)= K(i,j)*w(i)^(1-ssigma*ttheta/(ssigma-1));
    end
    Deno(j)=sum(Nume(:,j),1);
    for i=1:2
       lambda(i,j)= Nume(i,j)/Deno(j);
       X(i,j)     = lambda(i,j)*Y(j)/C3;
    end
    realwage(j)=kkappa(j)*lambda(j,j)^(-1/ttheta);
end


% You might think my coding below for psi11 and psi12 is wrong
% but note is that these two countries are symmetric in everything
% Alternatively, you can try to code up P
psi11=(ssigma*fxc(1,1)*realwage(1,1)^(ssigma-1)*(ssigma/(ssigma-1))^(ssigma-1)/Y(1))^(1/(ssigma-1));
psi12=(ssigma*fxc(1,2)*realwage(1,1)^(ssigma-1)*(Tau(1,2)*ssigma/(ssigma-1))^(ssigma-1)/Y(1))^(1/(ssigma-1));

Yshares=Y*(1/sum(Y));
% Saving results in structure
model.Y=Y;
model.Yshare=Yshares;
model.lambda=lambda;
model.X=X;
model.wages=realwage;
model.K=K;
model.psi11=psi11;
model.psi12=psi12;
model.av_prod=(ttheta/(ttheta+1-ssigma))^(1/(ssigma-1))*psi12;
model.kappa=kkappa;
end