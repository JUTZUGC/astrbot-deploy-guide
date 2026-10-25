# AstrBot 一键部署指南

> 第三方部署指南 · 非 AstrBot 官方仓库。官方项目：[AstrBotDevs/AstrBot](https://github.com/AstrBotDevs/AstrBot)
> 内容来自官方文档（2026-10-25）。项目迭代快，请以[官方文档](https://docs.astrbot.app)为准。

[![⚡ 一键部署](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E9%83%A8%E7%BD%B2-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键部署推荐用百度搭子)

## 一键部署（推荐：用百度搭子）

> [!TIP]
> 不用装 Python、不用改配置文件，让百度搭子把容器跑起来，打开面板就能接平台。

⚠️ 需要电脑已装 Docker（Windows / macOS / Linux 均可）。管理面板端口 6185，OneBot 适配器端口 6199。企业微信 / 微信公众号接入需要企业资质。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/astrbot-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会克隆仓库、用 Docker Compose 拉起容器，等管理面板能打开后把访问地址告诉你，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Docker；未安装时按对话提示安装。）

4. **打开管理面板**
   浏览器访问 [http://127.0.0.1:6185](http://127.0.0.1:6185)，按官方引导完成初始化配置。

## AstrBot 是什么？

AstrBot 是开源的多平台 AI Agent 助手与机器人开发框架（协议：AGPL-3.0，<img src="https://img.shields.io/github/stars/AstrBotDevs/AstrBot?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

一套代码把主流 IM 平台接上大模型：内置 Agent、MCP、Skills、知识库与人格设定；支持 QQ、企业微信、微信公众号、飞书、钉钉、Telegram、Slack、Discord 等平台；插件市场 1000+ 插件可一键安装，WebUI 可视化配置，不用手改配置文件。

- 支持平台：QQ / OneBot v11 / Telegram / 企业微信 / 微信公众号 / 飞书 / 钉钉 / Slack / Discord / LINE / KOOK / Satori / Misskey / Mattermost 等
- 模型服务：OpenAI 兼容接口、Anthropic、Gemini、DeepSeek、Moonshot、智谱、Ollama、LM Studio 等
- Agent 能力：MCP、Skills、知识库、人格设定、上下文自动压缩、Agent 沙盒
- 插件市场：1000+ 插件可一键安装，另有 Web ChatUI 可直接在浏览器对话

（来源：[官方仓库](https://github.com/AstrBotDevs/AstrBot)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 43.3k stars，更新活跃 | 最新 v4.29.3（2026-10-24），仓库当天仍有提交 |
| 平台覆盖广 | QQ / 企业微信 / 公众号 / 飞书 / 钉钉 / Telegram / Slack / Discord 等 15+ 平台 |
| Agent 能力强 | 原生 MCP、Skills、知识库、人格设定与 Agent 沙盒 |
| 插件生态大 | 插件市场 1000+ 插件可一键安装 |
| WebUI 配置 | 可视化面板，不用手改配置文件 |

| 需要注意 | 说明 |
|---|---|
| 依赖 Docker | 官方推荐 Docker 部署；源码部署需要 Python 3.12+ 与 uv |
| 要自备模型 Key | 接大模型需要自己的 API Key，按量计费 |
| 部分平台有资质门槛 | 企业微信 / 微信公众号需要企业资质；QQ 需配合 OneBot 实现或官方机器人平台 |
| AGPL-3.0 协议 | 二次分发或对外提供网络服务时要遵守 AGPL 条款 |
| 国内拉镜像慢 | 官方文档提供了 DaoCloud 镜像地址 |

> 以上基于官方文档与社区反馈整理（2026-10-25），以官方最新文档为准。

## 快速部署（官方方式）

```bash
git clone https://github.com/AstrBotDevs/AstrBot
cd AstrBot
docker compose up -d
```

启动后浏览器访问 [http://127.0.0.1:6185](http://127.0.0.1:6185)（管理面板）。适配器端口 6199（按需映射）。（来源：[https://docs.astrbot.app/deploy/astrbot/docker.html](https://docs.astrbot.app/deploy/astrbot/docker.html)）

## 验证状态

| 场景 | 状态 |
|---|---|
| Docker 镜像 soulter/astrbot:latest（amd64 / arm64）可查 | 已核对 2026-10-25 |
| MCP 服务握手与工具列表（initialize / tools/list） | 已验证 2026-10-25 |
| 非目标宿主调用被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-25 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

AstrBot 原生支持 MCP（WebUI → 插件 → MCP），支持 Streamable HTTP / SSE / stdio 三种连接方式。stdio 进程运行在 AstrBot 所在环境内，Docker 部署时装在容器里、装到宿主机无效；连接成功后还要在「人格设定 → 人格能力」里勾选对应工具，Agent 才会调用。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-25）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\astrbot-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 部署完成后：接模型和消息平台

1. 打开管理面板，用 `docker logs astrbot` 里打印的初始密码登录（用户名通常是 `astrbot`），先改密码
2. 「服务提供商」里新增模型（OpenAI 兼容接口 / DeepSeek / Gemini / Ollama 等），填自己的 API Key
3. 「消息平台」里新增适配器：QQ 需配合 OneBot v11 实现（如 NapCat），企业微信 / 飞书 / 钉钉按面板提示填应用凭证
4. 「插件 → MCP」可添加 MCP 服务器，支持 Streamable HTTP / SSE / stdio；stdio 的依赖要装在容器内

没有消息平台也能先用 Web ChatUI 在浏览器里对话。消息平台接入与 MCP 配置以[官方文档](https://docs.astrbot.app)为准。

## 常见坑

- 国内网络拉不动镜像：把 `compose.yml` 里的 `image: soulter/astrbot:latest` 换成 `m.daocloud.io/docker.io/soulter/astrbot:latest`（官方文档提供）
- 管理面板首次登录用启动日志里打印的随机初始密码（用户名通常是 `astrbot`），登录后立刻改密码
- 官方文档说明 Docker 下不要用 localhost 访问面板；127.0.0.1:6185 打不开时，用启动日志里打印的局域网地址
- 忘记面板密码：`docker exec -it astrbot astrbot password`，改完要 `docker restart astrbot` 才生效
- Docker 里 MCP 的 stdio 依赖要装在容器内，装到宿主机无效；当前官方镜像自带 Node.js 与 uv
- MCP 连上不等于模型会调用：还要到「人格设定 → 人格能力」里勾选该服务器的工具
- 云服务器部署需要在安全组放行 6185 端口
- Windows 若 compose 因 `/etc/localtime` 挂载报错，改用官方文档里 Windows Docker Desktop 的 `docker run` 命令

## 免责声明

本仓库为第三方指南，与 AstrBot 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-25），项目迭代快，请以[官方文档](https://docs.astrbot.app)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
