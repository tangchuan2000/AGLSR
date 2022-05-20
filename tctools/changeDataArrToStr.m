%将数组arr拼接成字符串，中间用slip隔开
function [str] = changeDataArrToStr(arr, slip)
    str = '';
    for len = 1:numel(arr)
        if (len ~= 1)
            str = strcat(str, slip);
        end
        str = strcat(str, num2str(arr(len)));
   end
end