--dialog("一秒后接收用户一次点击", 0);
--mSleep(1000);
--x,y = catchTouchPoint(); 
--dialog("x:"..x.." y:"..y, 0);

function click(x, y)
    touchDown(x, y)
    mSleep(30)
    touchMove(x, y) -- 安卓部分机型单点不生效的情况下可以加上此句
    touchUp(x, y)
    mSleep(1000)
end

click(122,849);
click(943,88);
mSleep(2000)
click(64,115);
click(772,364);