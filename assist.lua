-- 辅助脚本，用于取点
require("debug_util");
require("tips_util");
require("string_util");


w,h = getScreenSize();
local log = createLog("TAG");
MyJsonString = [[
{
  "style": "default",
  "width": ]]..(w*3/4)..[[,
  "height": ]]..(h*2/3)..[[,
  "views": [
    {
      "type": "Label",
      "text": "屏幕取点",
      "size": 25,
      "align": "center",
      "color": "0,0,255"
    },
    {
      "type": "Edit",
      "prompt": "取点数",
      "text": "0",
      "size": 15,
      "align": "left",
      "color": "255,0,0"
    },
  {
      "type": "CheckBoxGroup",
      "list": "设备类型,内存信息,系统版本号,设备系统,设备进程列表,设备名称,设备IP,设备品牌,设备型号,CPU型号,UUID,DPI&像素密度",
      "select": "0@1@2@3@4@5@6@7@8@9@10@11"
    }
  ]
}
]]
ret,input1,input2 = showUI(MyJsonString);

-- 取点处理函数
function fetchPoints(input)
  if input == "0" then return end
  showTips("取点数为:"..input.."个");
  local touchCount = tonumber(input);
  local ret = catchTouchPoint(touchCount);
  local str = "";
  for i = 1, #ret do  
    str = str.."第"..i.."次点击的位置:x="..ret[i].x..",y="..ret[i].y.."\n";
  end
  showAlert(str);
end


function fetchDevType()
    local types,name = getDeviceType();
    local showStr = "设备类型:";
    if types == 0 then
       showStr = showStr.."iPod Touch";
    elseif types == 1 then
       showStr = showStr.."iPhone";
    elseif types == 2 then
       showStr = showStr.."iPad";
    elseif types == 3 then
       showStr = showStr.."安卓真机";
    elseif types == 4 then
        showStr = showStr.."安卓模拟器,"..name; 
    end
    return showStr
end

function fetchMemInfo()
    local info = getMemoryInfo()
    return "剩余内存: "..info.free.."MB；总内存: "..info.total.."MB"
end

function fetchOSVer()
  local ver = getOSVer();
  return "系统版本号: "..ver;
end

function fetchOSType()
  local osType = getOSType();
  return "设备类型: "..osType;
end

local arr = string.split(input2,'@');


showStr = "";
for k,v in pairs(arr) do
    log(k,v);
    if "0" == v then
        showStr = showStr..fetchDevType().."\n"
    elseif "1" == v then
        showStr = showStr..fetchMemInfo().."\n"
    elseif "2" == v then
        showStr = showStr..fetchOSVer().."\n"
    elseif "3" == v then
        showStr = showStr..fetchOSType().."\n"
    end
end

showAlert(showStr)

log(input2);
showTips(input2);
fetchPoints(input1);
