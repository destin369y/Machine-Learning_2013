%hw2_4

clear all;
clc;

dVc=50;
% N=10000;
N=5;
P=0.95;
delta=1-P;

eOri=0;
while eOri<=( (8/N)*( log(4/delta)+dVc*log(2*N) ) )^0.5 
 eOri=eOri+0.0001;
end
fprintf('eOri = %d\n',eOri);

eRad=0;
while eRad<=( 2*( log(2*N)+dVc*log(N) )/N )^0.5 + ( (2/N)*log(1/delta) )^0.5 + 1/N   
 eRad=eRad+0.0001;
end
fprintf('eRad = %d\n',eRad);

ePar=0;
while ePar<=( (1/N)*( 2*ePar + log(6/delta)+dVc*log(2*N) ) )^0.5
 ePar=ePar+0.0001;
end
fprintf('ePar = %d\n',ePar);

eDev=0;
while eDev<=( (1/(2*N))*( 4*eDev*(1+eDev) + ( log(4/delta)+dVc*log(N*N) ) ) )^0.5
 eDev=eDev+0.0001;
end
fprintf('eDev = %d\n',eDev);


