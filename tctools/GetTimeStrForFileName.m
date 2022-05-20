function [stime]=GetTimeStrForFileName(pre)
    T = clock;
    st = sprintf('%s-%s-%s %s-%s.txt',num2str(T(1)),num2str(T(2)),num2str(T(3)),num2str(T(4)),num2str(T(5)));
    if (strlength(pre) > 2)
        pre = strcat(pre, '-');
        pre = strcat(pre, st);
        stime = pre;    
    else
        stime = st;
    end
end