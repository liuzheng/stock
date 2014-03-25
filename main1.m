load data.mat
pp=pwd;
sh=[];
sh=sz;
m=length(sh);
n=input('n=');
for i = n:min(570+100,m)
    mkdir(sh{i});
    %cd [pp '\' sh(i)];
    for j = datenum('2008-01-01'):today-1
        d=[];
        if isempty(find(holiday==j))
            d=yesterday(j,sh{i});
            save(['.\' sh{i} '\' num2str(j) '.mat'],'d');
           % xlswrite(['.\' sh{i} '\' num2str(j) '.xls'],d,1,'A1');
        end
    end
end

spk('程序运行结束')