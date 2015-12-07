clear all
D=importdata('dow_jones_index.data')
Price=zeros(750,4);
Vol=zeros(750,1);
P_Open=zeros(750,1);
b=D.textdata
j=0;
for i=2:12:361
   i
    ticker=b(i,2);
end


for j=4:7
for i=2:751
str=b(i,j);
[tok,rem]=strtok(str,'$');
b(i,j)=tok;
Price(i-1,j-3)=str2double(tok);
str=b(i,12);
[tok,rem]=strtok(str,'$');
P_Open(i-1)=str2double(tok);
str=b(i,8);
[tok,rem]=strtok(str,'');
Vol(i-1)=str2double(tok)/1000000000;
end
end
X=[Price Vol];
y=P_Open-X(:,4);
for i=1:750
    if y(i)>0
        y(i)=1;
    elseif y(i)<=0
        y(i)=-1;
    end
end
filename='StockData.mat'
save(filename);
        

