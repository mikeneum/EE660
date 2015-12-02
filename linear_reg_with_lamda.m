clear all
load('StockData.mat')
errRateMLE=zeros(30,1);
err=zeros(12,1);
j=0
for i=1:12:360
   j=1+j;
X_train =X(i:i+11,:);
y_train=P_Open(i:i+11);
y_train=standardizeCols(y_train);
X_train=standardizeCols(X_train);

%Create Test File
 
X_test=X(359+j+i:i+j+370, :)
X_test=standardizeCols(X_test);
y_test=P_Open(359+j+i:i+j+370);
y_test=standardizeCols(y_test)
end
lambdas = logspace(-10,1.3,10);
NL = length(lambdas);
printNdx = round(linspace(2, NL-1, 3));
testMse = zeros(1,NL); trainMse = zeros(1,NL);
for k=1:NL
  lambda = lambdas(k);
  [model] = linregFit(X_train, y_train, 'lambda', lambda);
  [ypredTest] = linregPredict(model, X_test)
  ypredTrain = linregPredict(model, X_train);
  testMse(k) = mean((ypredTest - y_test).^2);
  trainMse(k) = mean((ypredTrain - y_train).^2);
end


hlam=figure; hold on
ndx =  log(lambdas); % 1:length(lambdas);
plot(ndx, trainMse, 'bs:', 'linewidth', 2, 'markersize', 12);
plot(ndx, testMse, 'rx-', 'linewidth', 2, 'markersize', 12);
legend('train mse', 'test mse', 'location', 'northwest')
xlabel('log lambda')
title('mean squared error')


