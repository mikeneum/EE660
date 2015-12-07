
clear all
load('StockData.mat')
errRateMLE=zeros(30,1);
err=zeros(12,1);
j=0;
for i=1:12:360
   j=1+j;
X_train =X(i:i+11,:);
y_train=y(i:i+11);
%y_train=standardizeCols(y_train)
X_train=standardizeCols(X_train);


 
X_test=X(359+j+i:i+j+370, :);
X_test=standardizeCols(X_test);
y_test=y(359+j+i:i+j+370)
%y_test=standardizeCols(y_test)





% SVM
%model = svmFit(X_train, y_train);
model = svmFit(X_train, y_train, 'kernel', 'rbf', 'kernelParam', [0.1, 0.5, 1, 5], 'C', logspace(-2,2,100));
%model = svmFit(X_train, y_train, 'kernel', 'poly', 'kernelParam', [ 3, 6, 9, 10], 'C', logspace(-2,2,30));
%model = svmFit(X_train, y_train, 'kernel', 'sigmoid', 'kernelParam', [0.1, 0.5, 1, 5],'C', logspace(-2,2,100));


        yhat =  svmPredict(model,X_test)

for m=1:12
if yhat(m)==y_test(m)
    err(m)=0;
else
    err(m)=1;
end
end
sum(err)
errRateMLE(j)=sum(err)/12;
err=zeros(12,1);
end
mu=sum(errRateMLE)/30
model
figure;
bar(errRateMLE)
hold on
hline = refline([0 mu]);
hline.Color = 'r';

title('Mean error Sigmoid SVM')
xlabel('Dow Jones Companies')


ylabel('Mean Error')

