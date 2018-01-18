-- 调试用工具类

function createLog(tag)
    return function (...)
        local str = "";
        arg = { ... };
        for i,v in ipairs(arg) do
            str = " "..str..v;
        end
        nLog("["..tag.."]"..str);
    end
end