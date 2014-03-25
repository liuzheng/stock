clc;clear
gu='sz000001';
%day=today-4;
%load(['.\' gu '\' num2str(day) '.mat'])
load data
eval([gu '=[];']);
for i =datenum('2008-01-01'):today-1
    if find(holiday==i)
    else
        load(['.\' gu '\' num2str(i) '.mat']);
        D=[];
        for j=1:size(d)-1
            D(j)=str2num(d{j+1,2});
        end
        eval([gu '(end+1,1)= ' num2str(i) ';']);
        eval([gu '(end,2)= ' num2str(max(D)) ';']);
        eval([gu '(end,3)= ' num2str(min(D)) ';']);
        eval([gu '(end,4)= ' d{2,2} ';']);
        eval([gu '(end,5)= ' d{end,2} ';']);
        
    end
end
        