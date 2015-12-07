
clear all
load('StockData.mat')
errRateMLE=zeros(30,1);
err=zeros(6,1);
j=0
for i=1:12:360
   j=1+j;

X_train =X(i:i+11,:);
y_train=y(i:i+11); 
X_train1=X(359+j+i:i+j+365,:);
y_train1=y(359+j+i:i+j+365);
X_trainExt=vertcat(X_train,X_train1)
y_trainExt=vertcat(y_train,y_train1)
 
X_test=X(366+j+i:i+j+371, :)
X_test=standardizeCols(X_test);
y_test=y(366+j+i:i+j+371)
%y_test=standardizeCols(y_test);


%y_trainExt=standardizeCols(y_trainExt);
X_trainExt=standardizeCols(X_trainExt);



% Log Regression
model = logregFit(X_trainExt, y_trainExt);
yhat = logregPredict(model, X_test)
%errRateMLE(j) = mean(yhat ~= y_test);
%Linear Regression
%model = linregFit(X_train, y_train);
%yhat = linregPredict(model, X_test)
%delta=abs(yhat-y_test);
for m=1:6
if yhat(m)==y_test(m)
    err(m)=0;
else
    err(m)=1;
end
end
err
errRateMLE(j)=sum(err)/6
err=zeros(6,1);
end
mu=sum(errRateMLE)/30
figure;
bar(errRateMLE)
hold on
hline = refline([0 mu]);
hline.Color = 'r';

title('Mean error log regression')
xlabel('Dow Jones Companies')
%set(gca,'XTickLabel', {'AA','AXP','BA','BAC','CAT','CSCO','CVX',...
  %  'DD','DIS','GE','HD','HPQ','IBM','INTC','JNJ','JPM',...
   % 'KRFT','KO','MCD','MMM','MRK','MBFT','PPE','PG','T',...
   % 'TRV','UTX','VZ','WMT','XOM'})
ylabel('Mean Error')
