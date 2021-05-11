function ff=hatalgebra2countryMelitz(xvec)
global lambda0 Yshare0 Khat Lhat ssigma ttheta
w_hat(1,1)=1;
% w_hat(2,1)=model_init.wages;
% lambda_hat=xvec(2:end);
% lambda_hat=model_init.lambda;
% Fill in equation 20 in the lecture notes
% Equilibrium in the labor market
ff(1)=lambda0(2,1)*Yshare0(1)/Yshare0(2)*lambda_hat(2,1)*w_hat(1)*Lhat(1)...
     +lambda0(2,2)*Yshare0(2)/Yshare0(2)*lambda_hat(2,2)*w_hat(2)*Lhat(2)...
     -w_hat(2)*Lhat(2);
% Fill in numerator and denominator in equation 21
ind=2;
for j=1:2
    for i=1:2
       Nume(i,j)= Khat(i,j)*w_hat(i)^(1-ssigma*ttheta/(ssigma-1)); 
       Deno(i,j)= lambda0(i,j)*Nume(i,j);
    end
    Den(j)=sum(Deno(:,j),1);
    for i=1:2
        % Equation 22
       ff(ind)=lambda_hat(i,j)-Nume(i,j)/Den(j);
       ind=ind+1;
    end
end

end