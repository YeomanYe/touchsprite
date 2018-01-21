-- 辅助脚本，用于取点
require("debug_util");
require("tips_util");
require("string_util");


w,h = getScreenSize();
local log = createLog("TAG");
UIJson = [[
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
      "list": "设备类型,内存信息,系统版本号,系统类型,设备进程列表,设备名称,设备IP,设备品牌,设备型号,CPU型号,UUID,SD卡路径,DPI&像素密度",
      "select": "0@1@2@3@4@5@7@8@9@10@11@12"
    }
  ]
}
]]
ret,input1,input2 = showUI(UIJson);

ios = getOSType() ~= "android" and true or false

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

-- 获取DPI
function fetchDPI()
  local str = ""
  if not ios then
    local dpi,density = getDPI();
    str = "DPI:"..dpi..",像素比例:"..density 
  end
  return str
end

-- 获取UUID
function fetchUUID()
  local str = "UUID："
  if not ios then str = str..getUUID() end
  return str
end

-- 获取SD卡路径
function fetchSdPath()
  local str = "SD卡路径："
  local path = getSDCardPath()
  str = path == nil and "该设备没有SD卡" or str..path
  return str
end

-- 获取CPU型号
function fetchCpuType()
  local str = "CPU型号："
  if not ios then str = str..getCPUType() end
  return str
end

-- 获取设备型号
function fetchDevModel()
  local str = "设备型号："
  if not ios then str = str..getDeviceModel() end
  return str
end

-- 获取设备品牌
function fetchDevBrand()
  local str = "设备品牌："
  if not ios then str = str..getDeviceBrand() end
  return str
end

-- 获取网络IP
function fetchIP()
  return "网络IP："..getNetworkIP();
end

-- 获取设备名称
function fetchDevName()
  return "设备名称："..getDeviceName();
end

-- 获取设备进程列表
function fetchDevProcess()
  str = getProcess()
  text = "设备进程列表 总数 : " .. #str
  for _,v in ipairs(str) do
      text = "\n"..text .. v.id.." : "..v.name .. "\n"
  end
  return text
end

-- 设备类型
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

-- 内存信息
function fetchMemInfo()
    local info = getMemoryInfo(),str
  if ios then str = "触动服务占用内存 : "..info.self.."MB；剩余内存: "..info.free.."MB；总内存: "..info.total.."MB"
  else str = "剩余内存: "..info.free.."MB；总内存: "..info.total.."MB"
  end
  return str
end

-- 操作系统版本
function fetchOSVer()
  local ver = getOSVer();
  return "系统版本号: "..ver;
end

-- 系统类型
function fetchOSType()
  local osType = getOSType();
  return "系统类型: "..osType;
end

local arr = string.split(input2,'@');


showStr = "";
for k,v in pairs(arr) do
    log(k,v);
    if "0" == v then
        showStr = showStr..fetchDevType()
    elseif "1" == v then
        showStr = showStr..fetchMemInfo()
    elseif "2" == v then
        showStr = showStr..fetchOSVer()
    elseif "3" == v then
        showStr = showStr..fetchOSType()
    elseif "4" == v then
        showStr = showStr..fetchDevProcess()
    elseif "5" == v then
        showStr = showStr..fetchDevName()
    elseif "6" == v then
        showStr = showStr..fetchIP()
    elseif "7" == v then
        showStr = showStr..fetchDevBrand()
    elseif "8" == v then
        showStr = showStr..fetchDevModel()
    elseif "9" == v then
        showStr = showStr..fetchCpuType()
    elseif "10" == v then
        showStr = showStr..fetchUUID()
    elseif "11" == v then
        showStr = showStr..fetchSdPath()
    elseif "12" == v then
        showStr = showStr..fetchDPI()
    end
    showStr = showStr.."\n"
end

showAlert(showStr)

log(input2);
showTips(input2);
fetchPoints(input1);
