function [Z]=findeq2country(w0)
% Input : w0 (wage in the second country)
% Note  : The numeraire is final good produce in country 1 (at FOB)
% Output: Excess demand of labor
% Parameters in global: Tech, labor supply, iceberg costs, elasticity of
% substitution
global A  L Tau a_mat ssigma
% Fill in wages
w=[A(1,1),w0];
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
end
% Fill in excess of demand
Z=-w(1)*L(1);
for j=1:2
       Z=Z+ (Nume(1,j)/Deno(j))*w(j)*L(j);
end
end