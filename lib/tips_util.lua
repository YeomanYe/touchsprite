-- 显示提示框
function showTips(msg)
    toast(msg,1)
    mSleep(100);
end

-- 显示警告框
function showAlert(msg)
    dialog(msg);
end