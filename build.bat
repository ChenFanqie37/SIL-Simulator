@echo off
chcp 65001 >nul
echo ========================================
echo   韩娱嫂嫂模拟器 - 打包工具
echo ========================================
echo.
echo 正在检查 Node.js...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 未检测到 Node.js，请先安装：https://nodejs.org/
    echo 下载 LTS 版本，安装时勾选"Add to PATH"
    pause
    exit /b 1
)
echo Node.js 已安装 ✓
echo.
echo 正在安装依赖...
call npm install
if %errorlevel% neq 0 (
    echo [错误] 依赖安装失败
    pause
    exit /b 1
)
echo.
echo ========================================
echo   请选择打包平台：
echo   1. Windows (推荐)
echo   2. macOS
echo   3. Linux
echo   4. 全平台
echo   5. 仅运行测试
echo ========================================
set /p choice=请输入选项 (1-5):

if "%choice%"=="1" (
    echo 正在打包 Windows 版本...
    call npm run build:win
) else if "%choice%"=="2" (
    echo 正在打包 macOS 版本...
    call npm run build:mac
) else if "%choice%"=="3" (
    echo 正在打包 Linux 版本...
    call npm run build:linux
) else if "%choice%"=="4" (
    echo 正在打包全平台版本...
    call npm run build:all
) else if "%choice%"=="5" (
    echo 正在启动测试...
    call npm start
) else (
    echo 无效选项
    pause
    exit /b 1
)
echo.
echo ========================================
if "%choice%" neq "5" (
    echo 打包完成！
    echo 输出目录: dist\
    echo.
    echo Windows: dist\韩娱嫂嫂模拟器 Setup x.x.x.exe
    echo macOS:   dist\韩娱嫂嫂模拟器-x.x.x.dmg
    echo Linux:   dist\韩娱嫂嫂模拟器-x.x.x.AppImage
)
echo ========================================
pause
