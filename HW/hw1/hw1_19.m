%hw1_19

clear all;
clc;

trainF = load ('hw1_18_train.dat');
trainX=trainF(:,1:4);
trainY=trainF(:,5);
[nTrainX,mTrainX]=size(trainX);
trainX=[ones(nTrainX,1),trainX];

testF = load ('hw1_18_test.dat');
testX=testF(:,1:4);
testY=testF(:,5);
[nTestX,mTestX]=size(testX);
testX=[ones(nTestX,1),testX];

repNum=2000;
%corNumSum=0;
errorRateSum=0;
Eta=1;

for k=1:repNum
    s=RandStream('mt19937ar','seed',sum(100*clock));
    RandStream.setDefaultStream(s);
    R=randperm(nTrainX);
    
    %train
    wPLA=zeros(1,mTrainX+1);
    badPointLocal=0;
%     wPocket=zeros(1,mTrainX+1);
%     badPointPocket=nTrainX+1;
    corNum=0;
    updNum=50;
    badPoint=1;
    while ( (badPoint~=0)&&(corNum<updNum) )           
        badPoint=0;
        for i=1:nTrainX
           WtXn=dot(wPLA,trainX(R(i),:));
           if ( trainY(R(i))*WtXn<=0 )
              badPoint=badPoint+1;
              wPLA=wPLA+Eta*trainY(R(i))*trainX(R(i),:);
              corNum=corNum+1;
              
%               badPointLocal=0;
%               for j=1:nTrainX;
%                  WtXn=dot(wPLA,trainX(j,:));
%                  if ( trainY(j)*WtXn<=0 )
%                     badPointLocal=badPointLocal+1;
%                  end
%               end
%               if ( badPointLocal<badPointPocket )
%                  wPocket=wPLA;
%                  badPointPocket=badPointLocal;
%               end
           
           end

           if ( corNum==updNum )
              break;
           end          
        end   
    end
    
    %test
    errorPoint=0;
    for i=1:nTestX
%        WtXn=dot(wPocket,testX(i,:));
       WtXn=dot(wPLA,testX(i,:));
       if ( testY(i)*WtXn<=0 )
          errorPoint=errorPoint+1;
       end
    end
    errorRate=errorPoint/nTestX;
    errorRateSum=errorRateSum+errorRate;
   
end

%aveNumSum=corNumSum/repNum;
aveErrorRate=errorRateSum/repNum;
fprintf('Average Error Rate = %d\n',aveErrorRate);
