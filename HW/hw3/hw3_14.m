%hw3_14

clear all;
clc;

T=1000;
EinSum=0;
noise=0.1;
N=1000;

s=RandStream('mt19937ar','seed',sum(100*clock));
RandStream.setDefaultStream(s);
Xr=rand(N,2)*2-1;
noisePro=rand(N,1);
Y=sign(noisePro-noise).*sign(Xr(:,1).^2+Xr(:,2).^2-0.6);
Data=[Xr Y];
save hw3_14_data.dat Data;

%X=[ones(N,1),Xr];
Z=[ones(N,1), Xr(:,1), Xr(:,2), Xr(:,1).*Xr(:,2), Xr(:,1).^2, Xr(:,2).^2];
wLin=pinv(Z)*Y;
hZ=sign(Z*wLin);
[nEin,mEin]=size( find( hZ-Y ) );
Ein=nEin/N;

wA=[-1;-0.05;0.08;0.13;1.5;1.5];
hA=sign(Z*wA);
[nA,mA]=size( find( hZ-hA ) );

wB=[-1;-0.05;0.08;0.13;1.5;15];
hB=sign(Z*wB);
[nB,mB]=size( find( hZ-hB ) );

wC=[-1;-0.05;0.08;0.13;15;1.5];
hC=sign(Z*wC);
[nC,mC]=size( find( hZ-hC ) );

wD=[-1;-1.5;0.08;0.13;0.05;0.05];
hD=sign(Z*wD);
[nD,mD]=size( find( hZ-hD ) );

fprintf('Ein = %d\n',Ein);


