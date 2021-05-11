function [Z]=findeq2countryMelitz(w0)
% Input : w0 (wage in the second country)
% Note  : The numeraire is final good produce in country 1 (at FOB)
% Output: Excess demand of labor
% Parameters in global: Tech, labor supply, iceberg costs, elasticity of
% substitution
global ttheta L Tau  ssigma fxc M
% Fill in wages
w=[1,w0];
% Fill in K 
for i=1:2
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
end
% Fill in excess of demand
Z=-w(1)*L(1);
for j=1:2
       Z=Z+ (Nume(1,j)/Deno(j))*w(j)*L(j);
end
end