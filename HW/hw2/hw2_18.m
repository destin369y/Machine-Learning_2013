%hw2_18

clear all;
clc;

s=RandStream('mt19937ar','seed',sum(100*clock));
RandStream.setDefaultStream(s);
F=load('hw2_train.dat');
[m,n]=size(F);
X=F(:,1:n-1);
Y=F(:,n);
noise=0.2;

Xsort=zeros(m,n-1);
thr=zeros(m+1,n-1);
hX=zeros(m,n-1);
Ein1=zeros(m+1,n-1);
Ein2=zeros(m+1,n-1);
EinMinMin=1;

for dimX=1:n-1
    Xsort(:,dimX)=sort(X(:,dimX));
    thr(1,dimX)=( -1+Xsort(1,dimX) )/2;
    for i=2:m
        thr(i,dimX)=( Xsort(i-1,dimX)+Xsort(i,dimX) )/2;
    end
    thr(m+1,dimX)=( Xsort(m,dimX)+1 )/2;

    s=1;
    for i=1:m+1
        hX(:,dimX)=s*sign(X(:,dimX)-thr(i,dimX));
        [ErrSum,nErrSum]=size( find( hX(:,dimX)-Y ) );
        Ein1(i,dimX)=ErrSum/m;
    end
    [EinMin1,mEinMin1]=min(Ein1(:,dimX));

    s=-1;
    for i=1:m+1
        hX(:,dimX)=s*sign(X(:,dimX)-thr(i,dimX));
        [ErrSum,nErrSum]=size( find( hX(:,dimX)-Y ) );
        Ein2(i,dimX)=ErrSum/m;
    end
    [EinMin2,mEinMin2]=min(Ein2(:,dimX));

    if EinMin1<=EinMin2
        EinMin=EinMin1;
        if EinMin<EinMinMin
            EinMinMin=EinMin;
            EinMinS=1;
            EinMinDim=dimX;
            EinMinThr=thr(mEinMin1,dimX);
        end
    else
        EinMin=EinMin2;
        if EinMin<EinMinMin
            EinMinMin=EinMin;
            EinMinS=-1;
            EinMinDim=dimX;
            EinMinThr=thr(mEinMin2,dimX);
        end
    end
end

fprintf('Ein of the optimal decision stump = %d\n',EinMinMin);


