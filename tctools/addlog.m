function addlog(file,str,newLine)
%T = clock; 
%stime = sprintf('%s/%s/%s %s:%s:%s',num2str(T(1)),num2str(T(2)),num2str(T(3)),num2str(T(4)),num2str(T(5)),num2str(T(6)));
    if nargin < 3
        newLine = 0;
    end
    if (newLine == 1)
        %stime = GetTimeStrForLog();
        %str = sprintf(' %s %s\r\n', str, stime);
        str = sprintf(' %s \r\n', str);
    end   
    fd = fopen(file, 'a');
    fprintf(fd,'%s',str);
    fclose(fd);
end