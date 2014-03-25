function holidays
try load data.mat
    begin=max(holiday);
catch err
    begin=datenum('2008-01-01');
end
    
for j = begin:today-1
    d=[];
    if exist(['.\' sz{1} '\' num2str(j) '.mat'])
       % D=dir(['.\' sz{1} '\' num2str(j) '.mat']);
       % if D.bytes<200
       %     d=yesterday(j,sz{1});
       %     save(['.\' sz{1} '\' num2str(j) '.mat'],'d');
       % end
    else
        d=yesterday(j,sz{1},0);
        save(['.\' sz{1} '\' num2str(j) '.mat'],'d');
        D=dir(['.\' sz{1} '\' num2str(j) '.mat']);
    end
end
holiday=[];
for i = datenum('2008-01-01'):today-1
    a=dir(['.\' sz{1} '\' num2str(i) '.mat']);
    if a.bytes<200
        holiday=[holiday;i];
    end
end
save('data.mat','holiday','-append');
spk('程序运行完毕')