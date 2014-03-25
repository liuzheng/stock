load data.mat
pp=pwd;
sh=sz;
m=length(sh);
n=input('n=');
i=1;
%for i = n:m
    mkdir(sh{i});
    sh{i}
    i
    %cd [pp '\' sh(i)];
    for j = datenum('2008-01-01'):today-1
        d=[];
        %if isempty(find(holiday==j))
            if exist(['.\' sh{i} '\' num2str(j) '.mat'])
                D=dir(['.\' sh{i} '\' num2str(j) '.mat']);
                if D.bytes<10000
                    d=yesterday(j,sh{i});
                    save(['.\' sh{i} '\' num2str(j) '.mat'],'d');
                end
            else
                d=yesterday(j,sh{i});
                save(['.\' sh{i} '\' num2str(j) '.mat'],'d');
            end
        %end
    end
%end
spk('程序运行完毕')