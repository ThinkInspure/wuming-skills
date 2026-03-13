---
name: github-code-interpreter
description: >-
  GitHub 源码解读助手。当用户提供 GitHub 仓库链接（如 https://github.com/user/repo），
  并希望解读源码、理解原理、生成学习报告、或快速上手项目时使用。
  该 skill 会在 GitHub 文件夹中查找或克隆对应仓库，在 working 目录下创建解读文件夹，
  生成两份文档：（1）源码与原理解读报告（使用场景、优缺点、核心原理、设计思想、启发）
  （2）快速上手文档（安装、配置、运行步骤）。报告使用 Mermaid 图，并安排 1 小时后的复查完善。
---

# GitHub 源码解读助手

## 适用场景

- 用户发来 GitHub 仓库链接，并希望"解读源码""理解原理""分析架构""学习报告"
- 用户希望深入了解某个开源项目的实现细节和设计思想
- 用户需要快速上手某个项目，并希望有本地化的文档参考
- 用户希望结合源码学习，提取对自己研究或工作有价值的启发

以下情况不要使用本 skill：

- 用户只想克隆仓库，优先使用 `github-clone`
- 用户只想阅读论文，优先使用 `paper-interpreter`
- 用户只想翻译英文文章，优先使用 `article-translator`
- 用户只要简短的推荐语或简介，优先使用对应的推荐 skill

## 工作流

### 1. 确定工作目录

按以下优先级确定基础工作目录：

1. 用户明确指定的目录
2. 当前上下文中已经出现、明显属于 `working` 目录的现有子目录
3. `~/Documents/working`（默认）

不要跳出 `working` 目录体系。

### 2. 定位或克隆 GitHub 仓库

GitHub 仓库应该已经在 `~/Documents/coding/github` 目录下。首先检查：

```bash
cd ~/Documents/coding/github
ls -la | grep -i '<repo_name>'
```

如果仓库已存在，直接使用；如果不存在，克隆到该目录：

```bash
git clone https://github.com/<user>/<repo>.git
```

### 3. 创建解读工作区

在 working 目录下创建解读文件夹：

```bash
# 在 working 目录下选择合适的子目录
# 常见选择：
# - working/github-analysis/  (GitHub 源码分析)
# - working/learning/         (学习笔记)
# - working/tmp/              (临时分析)

mkdir -p ~/Documents/working/github-analysis/<repo_name>
cd ~/Documents/working/github-analysis/<repo_name>
```

### 4. 分析仓库结构

阅读并分析仓库的关键文件：

1. **README.md** - 项目介绍、使用方法
2. **package.json / setup.py / Cargo.toml** - 依赖、构建配置
3. **主要源码目录** - 核心实现代码
4. **文档目录** - docs/、docs/、*.md
5. **示例和测试** - examples/、tests/、__tests__/

生成仓库基本信息：

```bash
cd ~/Documents/coding/github/<repo_name>
# 统计代码量
find . -name "*.ts" -o -name "*.js" -o -name "*.py" -o -name "*.go" | xargs wc -l | tail -1
# 查看目录结构
tree -L 2 -I 'node_modules|target|__pycache__' > ~/Documents/working/github-analysis/<repo_name>/structure.txt
```

### 5. 生成两份文档

#### 5.1 源码与原理解读报告

文件名：`<repo_name>_源码解读.md`

内容包括：

- **项目基本信息**
  - 仓库地址、Star 数、最后更新时间
  - 项目描述、主要功能
  - 技术栈（语言、框架、依赖）

- **使用场景**
  - 这个项目解决什么问题
  - 适合在什么场景下使用
  - 典型应用案例

- **优点与缺点**
  - 优点：性能、设计、易用性等亮点
  - 缺点：局限性、不足、可改进点

- **核心原理**
  - 整体架构设计
  - 关键模块与数据流
  - 算法或核心逻辑
  - 技术选型理由

- **设计思想**
  - 代码组织方式
  - 设计模式应用
  - 抽象层次划分
  - 扩展性考虑

- **对悟鸣的启发**
  - 结合悟鸣当前岗位（AI 应用、Agent 开发、工具链建设）
  - 结合最近研究方向（Agent Skills、MCP、AI as Me）
  - 可以借鉴的设计思路或实现方法
  - 可以应用到自己项目的具体点

- **术语解释**
  - 项目中的专业术语或缩写
  - 特定技术的简要说明

- **Mermaid 图**
  - 项目架构图：`flowchart TD` 或 `graph TD`
  - 模块关系图：`flowchart LR`
  - 数据流图：`sequenceDiagram` 或 `flowchart`
  - 类关系图：`classDiagram`（如适用）

#### 5.2 快速上手文档

文件名：`<repo_name>_快速上手.md`

内容包括：

- **环境要求**
  - 操作系统、语言版本、依赖工具

- **安装步骤**
  - 克隆或下载仓库
  - 安装依赖（npm install / pip install / cargo build）
  - 配置说明（环境变量、配置文件）

- **快速体验**
  - 最小可运行示例
  - 核心功能演示
  - 预期输出

- **常见问题**
  - 安装过程中的坑
  - 依赖冲突解决
  - 调试建议

- **下一步学习**
  - 推荐阅读的源码文件
  - 关键模块的入口
  - 实验建议

### 6. 结合悟鸣背景补充启发

当需要输出"对悟鸣的启发"时，按需读取以下资料：

- `~/Documents/coding/our/skills-wuming/skills/personal-secretary/references/人物/我/04_工作相关.md`
- `~/Documents/coding/our/skills-wuming/skills/personal-secretary/references/人物/我/07_AI相关/07_AI探索.md`
- `~/Documents/coding/our/skills-wuming/skills/personal-secretary/references/人物/我/05_创作分享/05_我的创作经验.md`

补充时重点围绕这些维度：

- 当前岗位是否与 AI 应用、Agent 开发、工具链、开发者体验相关
- 最近研究是否与 Agent Skills、MCP、AI 协作、知识管理相关
- 可以如何借鉴这个项目的设计思路到自己的 Skills 开发中
- 是否适合写公众号文章介绍这个项目

### 7. 初稿完成要求（必须执行）⚠️

**生成初版报告后，必须立即向用户发送两份文档**：

- 发送源码解读报告：`<repo_name>_源码解读.md`
- 发送快速上手文档：`<repo_name>_快速上手.md`
- 使用渠道提供的文件发送功能（QQ 使用 `<qqfile>标签`）
- 提醒用户这是初稿，后续会有复查任务完善内容
- 说明复查时间（1 小时后）

发送示例（QQ）：
```
✅ GitHub 源码解读初稿已生成！

📄 源码解读报告：<qqfile>源码解读文件路径</qqfile>
📄 快速上手文档：<qqfile>快速上手文件路径</qqfile>
⏰ 初稿复查时间：1 小时后（自动完善）
📝 当前版本：v1.0 初稿
```

### 8. 安排延迟复查

初版报告完成后，主动安排 1 小时后的复查任务：

- 如果支持定时任务，创建 1 小时后的复查
- 如果不支持，明确告诉用户这一限制
- 在报告中记录复查安排

### 9. 复查任务的更新原则

复查时遵循增量更新：

- 先读取当前两份文档
- 再检查仓库是否有更新（git pull）
- 优先补充遗漏的架构细节、使用场景、设计思想
- 检查快速上手文档的准确性（实际运行验证）
- 在文档末尾添加 `复查记录` 时修改了啥

### 10. 输出要求

#### 初版报告完成后的必须操作⚠️

**第一步：发送两份文档文件**
- 使用渠道提供的文件发送功能（QQ 使用 `<qqfile>标签`）
- 发送 `<repo_name>_源码解读.md`
- 发送 `<repo_name>_快速上手.md`
- 附带简短说明：
  - 初稿已完成
  - 复查时间（1 小时后）
  - 当前版本信息

**第二步：汇报基本信息**
- GitHub 仓库本地路径
- 解读文档目录路径
- 两份文档的文件名
- 源码解读报告的主要内容概要
- 快速上手文档的关键步骤
- 复查任务是否成功安排

**注意**：必须先发送文件，再汇报信息。不要反过来。

如果仓库过于庞大（如 React、Vue 等超大型项目），要明确说明分析范围，可能需要聚焦某个模块或子系统。

## 工具建议

分析时可以使用以下工具辅助：

```bash
# 代码统计
tokei ~/Documents/coding/github/<repo_name>

# 依赖分析
# Node.js
npm list --depth=0
# Python
pip list
# Rust
cargo tree

# 架构图辅助
# 使用 tree 命令生成目录结构
tree -L 3 -I 'node_modules|target|__pycache__|dist|build'
```

## 注意事项

1. **仓库规模**：大型项目需要明确分析范围，可以聚焦核心模块
2. **语言差异**：根据项目语言调整分析重点（如前端关注组件架构，后端关注服务设计）
3. **版本选择**：优先分析稳定版或主分支，避免过时版本
4. **文档优先**：先读官方文档，再读源码，避免误解设计意图
5. **实践验证**：快速上手文档建议实际运行验证，确保准确性

## 报告模板参考

使用 [references/report-outline.md](references/report-outline.md) 中的结构作为基础模板，根据项目特点灵活调整。
