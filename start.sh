#!/bin/bash
echo ""
echo "  💕 韩娱嫂嫂模拟器 - 本地服务器"
echo "  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if ! command -v python3 &> /dev/null; then
    if ! command -v python &> /dev/null; then
        echo "  ❌ 未检测到 Python，请先安装 Python"
        echo "  或者直接用浏览器打开 index.html 也可以玩！"
        exit 1
    fi
    PY=python
else
    PY=python3
fi

IP=$(ipconfig getifaddr en0 2>/dev/null || hostname -I 2>/dev/null | awk '{print $1}')

echo "  🌐 正在启动服务器..."
echo ""
echo "  📱 手机访问: http://$IP:8000"
echo "  💻 电脑访问: http://localhost:8000"
echo ""
echo "  ⚠️ 按 Ctrl+C 停止服务器"
echo ""

cd "$(dirname "$0")"
$PY -m http.server 8000
