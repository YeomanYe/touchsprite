-- 辅助脚本，用于取点
w,h = getScreenSize();
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
      "text": "1",
      "size": 15,
      "align": "left",
      "color": "255,0,0"
    },
  {
      "type": "CheckBoxGroup",
      "list": "设备类型,内存信息,系统版本号,设备系统,设备进程列表,设备名称,设备IP,设备品牌,设备型号,CPU型号,UUID,DPI&像素密度",
      "select": "3@5"
    }
  ]
}
]]
ret,input1,input2 = showUI(MyJsonString);
-- 显示提示框
function showTips(msg)
    toast(msg,1)
    mSleep(100);
end
-- 取点处理函数
function fetchPoints(input)
  if input == nil then return end
  showTips("取点数为:"..input.."个");
  local touchCount = tonumber(input);
  local ret = catchTouchPoint(touchCount);
  local str = "";
  for i = 1, #ret do  
    str = str.."第"..i.."次点击的位置:x="..ret[i].x..",y="..ret[i].y.."\n";
  end
  dialog(str);
end
showTips(input2);
fetchPoints(input1);
