
clear all
load('StockData.mat')
errRateMLE=zeros(30,1);
err=zeros(6,1);
mu=zeros(1000,1);
lambdas = logspace(-10,1.3,1000);
NL = length(lambdas);

for k=1:1
 

j=0;
for i=1:12:360
   j=1+j;

X_train =X(i:i+11,:);
y_train=P_Open(i:i+11); 
X_train1=X(359+j+i:i+j+365,:);
y_train1=P_Open(359+j+i:i+j+365);
X_trainExt=vertcat(X_train,X_train1)
y_trainExt=vertcat(y_train,y_train1)
 
X_test=X(366+j+i:i+j+371, :)
X_test=standardizeCols(X_test);
y_test=P_Open(366+j+i:i+j+371)
y_test=standardizeCols(y_test);


y_trainExt=standardizeCols(y_trainExt);
X_trainExt=standardizeCols(X_trainExt);




% MLE
%model = logregFit(X_train, y_train);
%yhat = logregPredict(model, X_test);
%errRateMLE(j) = mean(yhat ~= y_train);
%Linear Regression
lambda = 7.8146;
model = linregFit(X_trainExt, y_trainExt, 'lambda',lambda);
yhat = linregPredict(model, X_test);
delta=(yhat-y_test);
for m=1:6
if delta(m)>=0
    err(m)=0;
else
    err(m)=1;
end

  
end


errRateMLE(j)=sum(err)/6;
err=zeros(6,1);
end
mu(k)=sum(errRateMLE)/30
figure;
bar(errRateMLE)

hold on
hline = refline([0 mu(k)]);
%
title('Mean error linear regression: lambda=7.8')
xlabel('Dow Jones Companies')

ylabel('Mean Error')
end
