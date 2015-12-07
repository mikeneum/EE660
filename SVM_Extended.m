
clear all
load('StockData.mat')
errRateMLE=zeros(30,1);
err=zeros(12,1);
j=0;
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






% SVM
%model = svmFit(X_train, y_train);
%model = svmFit(X_trainExt, y_trainExt, 'kernel', 'rbf', 'kernelParam', [0.1, 0.5, 1, 5], 'C', logspace(-1,1,10));
%model = svmFit(X_trainExt, y_trainExt, 'kernel', 'poly', 'kernelParam', [1,3 ,6, 9, 10], 'C', logspace(-2,2,30));
model = svmFit(X_trainExt, y_trainExt, 'kernel', 'sigmoid', 'kernelParam', [0.1, 0.5, 1, 5],'C', logspace(-2,2,100));


        yhat =  svmPredict(model,X_test)

for m=1:6
if yhat(m)==y_test(m)
    err(m)=0;
else
    err(m)=1;
end
end
sum(err)
errRateMLE(j)=sum(err)/6;
err=zeros(6,1);
end
mu=sum(errRateMLE)/30
figure;
bar(errRateMLE)
hold on
hline = refline([0 mu]);
hline.Color = 'r';

title('Mean error RBF SVM')
xlabel('Dow Jones Companies')


ylabel('Mean Error')

