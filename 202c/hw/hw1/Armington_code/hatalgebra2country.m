function ff=hatalgebra2country(xvec)
global lambda0 Yshare0 Khat Lhat ssigma 

% ff = RHS - LHS for eqn (17) & (18) in the lecture on Hat algebra
% For 2-country model, we need 3 (rather than 4) ff conditions 

w_hat(1,1)=1;
w_hat(2,1)=xvec(1);
lambda_hat=xvec(2:end);
lambda_hat=reshape(lambda_hat,2,2);
% Fill in eq (17) in the lecture notes
% Equilibrium in the labor market
% Here I am only writing down eqn (17) for one the two countries
ff(1)=lambda0(2,1)*Yshare0(1)/Yshare0(2)*lambda_hat(2,1)*w_hat(1)*Lhat(1)...
     +lambda0(2,2)*Yshare0(2)/Yshare0(2)*lambda_hat(2,2)*w_hat(2)*Lhat(2)...
     -w_hat(2)*Lhat(2);
 
 
% Fill in numerator and denominator in eqn (17)
index=2;
for j=1:2
    for i=1:2
       Nume(i,j)= Khat(i,j)*w_hat(i)^(1-ssigma);
       Deno(i,j)= lambda0(i,j)*Nume(i,j);
    end
    Den(j)=sum(Deno(:,j),1);
    
    % eqn (18) in lecture notes
    % writing down eqn (18) for both countries, which make ff(2) and ff(3) 
    for i=1:2
       ff(index)=lambda_hat(i,j)-Nume(i,j)/Den(j);
       index=index+1;
    end
end

end