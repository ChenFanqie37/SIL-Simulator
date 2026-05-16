@echo off
chcp 65001 >nul
echo.
echo  💕 韩娱嫂嫂模拟器 - 本地服务器
echo  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo.

where python >nul 2>nul
if %errorlevel% neq 0 (
    echo  ❌ 未检测到 Python，请先安装 Python
    echo  下载地址: https://www.python.org/downloads/
    echo.
    echo  或者直接双击 index.html 用浏览器打开也可以玩！
    pause
    exit /b
)

echo  🌐 正在启动服务器...
echo.
echo  📱 手机访问方法:
echo     1. 手机和电脑连同一个WiFi
echo     2. 手机浏览器打开下面的地址
echo.

for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4"') do (
    for /f "tokens=1" %%b in ("%%a") do (
        echo  📱 手机访问: http://%%b:8000
    )
)

echo  💻 电脑访问: http://localhost:8000
echo.
echo  ⚠️ 关闭此窗口即可停止服务器
echo.

cd /d "%~dp0"
python -m http.server 8000
