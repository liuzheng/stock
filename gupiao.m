function [out name]=gupiao(gu,n,g)
pp={'时间','今日开盘价','昨日收盘价','当前价格','今日最高价','今日最低价','竞买价',...
    '竞卖价','成交的股票数','成交金额','买一申','买一价','买二申','买二价','买三申',...
    '买三价','买四申','买四价','买五申','买五价','卖一申','卖一价','卖二申','卖二价',...
    '卖三申','卖三价','卖四申','卖四价','卖五申','卖五价','0'};
p=[];
if nargin<3
    g=1;
end
if nargin<2
    n=1;
end
if nargin<1 
    gu='sz000089';
end
for j=1:n
a=urlread(['http://hq.sinajs.cn/list=' gu],'get','','GBK');
yin=regexp(a,'"');
dou=regexp(a,',');
if numel(dou)==0
    out=[];
    return;
end
n=max(size(dou));
name = a(yin(1)+1:dou(1)-1);
for i=1:n-3
    finance{i} = str2num(a(dou(i)+1:dou(i+1)-1));
end
i=i+1;
riqi = a(dou(i)+1:dou(i+1)-1);
i=i+1;
shijian{1} = a(dou(i)+1:dou(i+1)-1);
finance{end+1} = str2num(a(dou(end)+1:yin(end)-1));
p=[p;shijian finance];
finance=[];
end
pp=[pp;p];
if g==1
    out=pp;
else
    out=p;
end
%预期收益=投资本金×预期最高年化收益率/365×实际存续天数