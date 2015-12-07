
clear all
load('StockData.mat')
errRateMLE=zeros(30,1);
err=zeros(12,1);
j=0
for i=1:12:360
   j=1+j;
X_train =X(i:i+11,:)
y_train=P_Open(i:i+11);
y_train=standardizeCols(y_train);
X_train=standardizeCols(X_train);


 
X_test=X(359+j+i:i+j+370, :)
X_test=standardizeCols(X_test)
y_test=P_Open(359+j+i:i+j+370);
y_test=standardizeCols(y_test);





% MLE
%model = logregFit(X_train, y_train);
%yhat = logregPredict(model, X_test);
%errRateMLE(j) = mean(yhat ~= y_train);
%Linear Regression
model = linregFit(X_train, y_train);
yhat = linregPredict(model, X_test)
delta=(yhat-y_test);
for m=1:12
if delta(m)>=0
    err(m)=0;
else
    err(m)=1;
end
end
err
errRateMLE(j)=sum(err)/12
err=zeros(12,1);
end
mu=sum(errRateMLE)/30
figure;
bar(errRateMLE)
hold on
hline = refline([0 mu]);
hline.Color = 'r';

title('Mean error linear regression')
xlabel('Dow Jones Companies')
%set(gca,'XTickLabel', {'AA','AXP','BA','BAC','CAT','CSCO','CVX',...
  %  'DD','DIS','GE','HD','HPQ','IBM','INTC','JNJ','JPM',...
   % 'KRFT','KO','MCD','MMM','MRK','MBFT','PPE','PG','T',...
   % 'TRV','UTX','VZ','WMT','XOM'})
ylabel('Mean Error')
