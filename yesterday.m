function [Detail warn]=yesterday(date,symbol,warning)
% date formate is that date='2013-03-12' or any format 
% symbol formate is that symbol='sh600900'

if nargin==2
    warning=1;% warning on
end
warn=0;
a=urlread(['http://market.finance.sina.com.cn/downxls.php?date=' datestr(date,29) '&symbol=' symbol],'get','','GBK');
if warning | regexp(a,'window')| isempty(a)
    Detail=[];
    warn=1;
    warndlg('请检查网络连接或该天为休息日','注意！！！')
    return;
end
j=regexp(a,'\s');   % Blank please
k=regexp(a,'\t');   % Teb please
l=setdiff(j,k);     % Space please
m=length(l);
k=reshape(k,5,m);
l=[0,l];
%Detail={'成交时间'	'成交价'	'价格变动'	'成交量(手)'	'成交额(元)'	'性质'};
for i=1:m
    Detail{i,1}=a(l(i)+1:k(1,i)-1);
    for ii=2:5
        Detail{i,ii}=a(k(ii-1,i)+1:k(ii,i)-1);
    end
    Detail{i,6}=a(k(5,i)+1:l(i+1)-1);
end
end