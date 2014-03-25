function a=date2second(s)
d=regexp(s,':');
a=str2num(s(1:d(1)-1))*3600+str2num(s(d(1)+1:d(2)-1))*60+str2num(s(d(2)+1:end));
end