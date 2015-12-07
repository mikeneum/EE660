
clear all
load('StockData.mat')
errRateMLE=zeros(30,1);
err=zeros(12,30);
mu=zeros(1000,1);
lambdas = logspace(-10,1.3,1000);
NL = length(lambdas);
DJIA=zeros(12,1)
for k=1:1
 

j=0;
for i=1:12:360
   j=1+j;
X_train =X(i:i+11,:);
y_train=P_Open(i:i+11);
y_train=standardizeCols(y_train);
X_train=standardizeCols(X_train);


 
X_test=X(359+j+i:i+j+370, :);
X_test=standardizeCols(X_test);
y_test=P_Open(359+j+i:i+j+370);
y_test=standardizeCols(y_test);






%Linear Regression with best lambda
lambda = 0.0;
model = linregFit(X_train, y_train, 'lambda',lambda);
yhat = linregPredict(model, X_test);
delta=(yhat-y_test);
for m=1:12
if delta(m)>=0
    err(m,j)=0;
else
    err(m,j)=1;
end

  
end



end
DJIAerr=sum(err,2)/30
figure;
bar(DJIAerr)
hold on





date=[1 2 3 4 5 6 7 8 9 10 11 12]';
fitpoly3=fit(date,DJIAerr,'poly3')
% Plot the fit with the plot method.
plot(fitpoly3,date,DJIAerr)
title('Linear Regression 2nd Quarter Performance')
xlabel('2nd QTR. Week')
ylabel('DJIA Mean Error')

% Move the legend to the top right corner.
legend('Location','NorthEast' );


end

