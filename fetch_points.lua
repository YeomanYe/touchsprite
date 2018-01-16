-- 辅助脚本，用于取点
w,h = getScreenSize();
MyJsonString = [[
{
  "style": "default",
  "width": ]]..(w/2)..[[,
  "height": ]]..(h/4)..[[,
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
      "text": "1",
      "size": 15,
      "align": "left",
      "color": "255,0,0"
    }
  ]
}
]]
ret,input1 = showUI(MyJsonString);
function showTips(msg)
    toast(msg,1)
    mSleep(100);
end

showTips("取点数为:"..input1.."个");

local touchCount = tonumber(input1);
local ret = catchTouchPoint(touchCount);
local str = "";
for i = 1, #ret do  
    str = str.."第"..i.."次点击的位置:x="..ret[i].x..",y="..ret[i].y.."\n";
end
dialog(str);