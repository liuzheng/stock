clc;clear;clf

h=figure(1); %创建窗口
%{
load data.mat
holiday=[];
for i = datenum('2008-01-01'):today-1
    a=dir(['.\sz000001\' num2str(i) '.mat']);
    if a.bytes<200
        holiday=[holiday;i];
    end
end
save data sh sz die holiday
%}
gu='sz000001';
day=today-8;
load(['.\' gu '\' num2str(day) '.mat'])
[n m]=size(d);
x=[];
y=[];
z=[];
for i=2:n
    x=[x;date2second(d{i,1})];
    y=[y;str2num(d{i,2})];
    z=[z;str2num(d{i,4})];
end
x=x-(x>46800)*5400;
x=x/1000;
Y=[x y];
Z=[x z];
Z=sortrows(Z,1);
Y=sortrows(Y,1);
X=Z;
for i = n-2:-1:1
    if Z(i,1)==Z(i+1,1)
        Y(i+1,:)=[];
        Z(i,2)=Z(i+1,2)+Z(i,2);
        Z(i+1,:)=[];
        j=3;
        while 1
            try X(i,j);
                if X(i,j)==0
                    X(i,3:2+length(X(i+1,2:end-1)))=X(i+1,2:end-1);
                    X(i+1,:)=[];
                    break;
                end
            catch err
                X(i,3:2+length(X(i+1,2:end)))=X(i+1,2:end);
                X(i+1,:)=[];
                break;
            end
            j=j+1;
        end
    end
end
[AX H1 H2]=plotyy(Z(:,1),Z(:,2),Y(:,1),Y(:,2));
set(H1,'LineStyle','.','Color','w')
xtk=34200:1800:48600;
xtk=xtk/1000;
xtk_label={'9:30' '10:00' '30' '11:00' '11:30/13:00' '30' '14:00' '30' '15:00'};
hold on 
bar(X(:,1),X(:,2:end),'stack')
set(AX,'xtick',xtk);set(AX,'xticklabel',xtk_label);
grid on
[out name]=gupiao(gu);
%{
get(h,'CurrentPoint') %获得句柄
msgstr = sprintf('x = %3.0f; y = %3.0f',get(h,'CurrentPoint')) %获得位置
dispbox = uicontrol('style','text','backgroundcolor','k','foregroundcolor','y','units','normalized',...
'position',[0.065 0.02 0.32 0.04],'string',msgstr,... 
'horizontalalignment','l'); 
%}
title([datestr(day,26) name])

%spk('程序运行完毕')
