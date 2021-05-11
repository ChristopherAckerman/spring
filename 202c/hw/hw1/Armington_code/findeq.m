function [Z0]=findeq(wvec0)
global A S L Tau a_mat ssigma
% Numeraire p_11=1
wvec=[A(1,1),wvec0];
K=(a_mat.*(Tau.^(1-ssigma))).*((ones(S,1)*A.^(ssigma-1))');
Num=K.*((ones(S,1)*(wvec).^(1-ssigma))');
Den=sum(Num,1);
Y=wvec.*L;
Z=(sum((Num./(ones(S,1)*Den)).*(ones(S,1)*Y),2)-Y');
Z0=Z(2:end);
end