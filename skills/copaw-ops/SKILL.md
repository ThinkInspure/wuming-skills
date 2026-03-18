---
name: copaw-ops
description: CoPaw 运维助手。用于用户提到 copaw 运维、服务无响应、渠道断连、MCP 失败、模型调用失败、cron 不执行、Docker 部署、重载、重启或重置恢复时使用。优先执行状态检查与故障分流；涉及重启、重载、重置、配置修改等高影响动作时，先向用户说明再执行。
---

# CoPaw Ops

本技能用于 CoPaw 的日常巡检、故障定位与恢复操作，优先给出可执行命令和最短恢复路径。

## 设计模式

本 skill 主要采用：
- **Tool Wrapper**：提供 CoPaw 命令、诊断路径和参考资料
- **Runbook / Pipeline**：按“状态检查 → 问题分流 → 选择修复动作 → 验证结果”的顺序执行
- **Reviewer（轻度）**：先判断问题类型，再决定是否需要恢复动作

## Gotchas

- 不要一上来就重启或重置，先看状态和症状
- 涉及重启、reload、init --force、重置、配置修改等高影响动作时，要先向用户说明再执行
- 不要把模型问题、渠道问题、daemon 问题、cron 问题混成一个通用修复命令
- 不要假装 Magic Commands 在所有环境都可用，要先判断当前渠道/环境是否支持
- 修复后一定要回到状态检查，不要停在“命令执行了”

## 触发场景

- 用户要求排查 CoPaw 服务不可用、响应慢、报错。
- 用户要求查看或修改 CoPaw 配置、模型、渠道、定时任务、会话。
- 用户要求执行 CoPaw 重启、重载、清理、重置。
- 用户要求 Docker / supervisord 场景下的 CoPaw 运维操作。

## 标准诊断流程

### 0. 先判断是否需要确认

以下操作默认可以直接做：
- `copaw daemon status`
- `copaw daemon version`
- `copaw models list`
- `copaw channels list`
- `copaw cron list`
- `copaw daemon logs -n 100`

以下操作属于高影响动作，执行前应先向用户说明：
- `copaw daemon reload-config`
- `/restart`
- `/daemon restart`
- `copaw init --force`
- 任何明确会修改配置、重连渠道、重置状态的命令

当用户报告 CoPaw 故障时，按以下最小闭环执行：

```bash
# 1) 基础状态
copaw daemon status
copaw daemon version

# 2) 关键运行面检查
copaw models list
copaw channels list
copaw cron list

# 3) 最近日志
copaw daemon logs -n 100

# 4) 针对性恢复（按症状）
copaw daemon reload-config
```

若在聊天渠道中可直接执行 Magic Commands，则优先：

```text
/status
/restart
/daemon logs 50
```

## 故障分流

- 服务无响应：先 `/restart`，再 `copaw daemon reload-config`，仍失败再按部署方式重启进程。
- 配置错误：`copaw daemon reload-config` + `copaw daemon logs -n 200`，必要时 `copaw init --force`。
- 渠道断连：`copaw channels list` -> `copaw channels config` -> `/daemon restart`。
- 模型调用失败：`copaw models list` -> `copaw models config-key <provider>` -> `copaw models set-llm`。
- 定时任务不执行：`copaw cron state <job_id>` -> `copaw cron resume <job_id>` -> `copaw cron run <job_id>`。
- 上下文爆满：`/compact` 或 `/new`，并用 `/history` 验证 Token 使用。

## 成功判定标准

- `copaw daemon status` 正常，且无关键报错。
- `copaw channels list` 渠道状态符合预期。
- `copaw models list` 当前模型可用。
- `copaw cron list` / `copaw cron state <job_id>` 显示任务正常。
- 最近日志未持续出现相同错误。

## 按需加载参考

- 常用命令与巡检清单：`references/copaw_commands.md`
- 故障恢复策略：`references/copaw_recovery.md`

## 回复模板

向用户汇报时使用以下结构：

1. 现象：用户侧症状 + 影响范围
2. 诊断：执行过的命令与关键输出
3. 处理：已执行恢复动作
4. 结果：当前状态是否恢复
5. 建议：后续预防或观察项

