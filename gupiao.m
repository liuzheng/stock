function [out name]=gupiao(gu,n,g)
pp={'ʱ��','���տ��̼�','�������̼�','��ǰ�۸�','������߼�','������ͼ�','�����',...
    '������','�ɽ��Ĺ�Ʊ��','�ɽ����','��һ��','��һ��','�����','�����','������',...
    '������','������','���ļ�','������','�����','��һ��','��һ��','������','������',...
    '������','������','������','���ļ�','������','�����','0'};
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
%Ԥ������=Ͷ�ʱ����Ԥ������껯������/365��ʵ�ʴ�������