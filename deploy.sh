#!/usr/bin/env bash
set -euo pipefail
# AstrBot 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://docs.astrbot.app
# 更新日期：2026-10-25
# 类型：docker
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }
command -v docker >/dev/null 2>&1 || { echo "需要先安装 Docker"; exit 1; }
docker compose version >/dev/null 2>&1 || { echo "需要 Docker Compose v2（docker compose 子命令）"; exit 1; }

mkdir -p .download
cd .download

git clone https://github.com/AstrBotDevs/AstrBot
cd AstrBot
docker compose up -d

echo ""
if command -v curl >/dev/null 2>&1; then
  echo "等待服务启动：http://127.0.0.1:6185"
  ready=0
  for _ in $(seq 1 30); do
    if curl -sS -o /dev/null "http://127.0.0.1:6185" 2>/dev/null; then ready=1; break; fi
    sleep 2
  done
  if [ "$ready" = "1" ]; then
    echo "服务已就绪"
  else
    echo "警告：60 秒内未探测到 http://127.0.0.1:6185，请手动打开确认或查看日志"
    exit 1
  fi
else
  echo "未检测到 curl，跳过启动探测；请手动访问 http://127.0.0.1:6185 确认"
fi
echo "部署完成：浏览器打开管理面板，用启动日志里的初始密码登录，先改密码再接消息平台"
echo "若结果异常或需要改配置，请参考官方文档：https://docs.astrbot.app"
