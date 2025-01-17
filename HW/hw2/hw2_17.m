%hw2_17

clear all;
clc;

T=5000;
EinSum=0;
EoutSum=0;
noise=0.2;
for t=1:T
    s=RandStream('mt19937ar','seed',sum(100*clock));
    RandStream.setDefaultStream(s);
    X=rand(20,1)*2-1;
    noisePro=rand(20,1);
    Y=sign(noisePro-noise).*sign(X);
    Data=[X Y];
    save hw2_17_data.dat Data;
    
    Xsort=sort(X);
    thr=zeros(21,1);
    thr(1)=( -1+Xsort(1) )/2;
    for i=2:20
        thr(i)=( Xsort(i-1)+Xsort(i) )/2;
    end
    thr(21)=( Xsort(20)+1 )/2;

    hX=zeros(20,1);

    s=1;
    Ein1=zeros(21,1);
    for i=1:21
        hX=s*sign(X-thr(i));
        [ErrSum,nErrSum]=size( find( hX-Y ) );
        Ein1(i)=ErrSum/20;
    end
    [EinMin1,mEinMin1]=min(Ein1);

    s=-1;
    Ein2=zeros(21,1);
    for i=1:21
        hX=s*sign(X-thr(i));
        [ErrSum,nErrSum]=size( find( hX-Y ) );
        Ein2(i)=ErrSum/20;
    end
    [EinMin2,mEinMin2]=min(Ein2);

    if EinMin1<=EinMin2
        Ein=EinMin1;
        Eout=( abs( thr(mEinMin1) )/2 )*(1-noise)+( 1-( abs( thr(mEinMin1) )/2 ) )*noise;
        %Eout=abs( thr(mEinMin1) )/2;
    else
        Ein=EinMin2;
        Eout=( abs( thr(mEinMin2) )/2 )*noise+( 1-( abs( thr(mEinMin2) )/2 ) )*(1-noise);
        %Eout=1-abs( thr(mEinMin2) )/2;
    end
    EinSum=EinSum+Ein;
    EoutSum=EoutSum+Eout;

end
EinAve=EinSum/T;
EoutAve=EoutSum/T;

fprintf('Average Ein = %d\n',EinAve);
fprintf('Average Eout = %d\n',EoutAve);


