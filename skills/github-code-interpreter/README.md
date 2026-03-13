# GitHub 源码解读助手

一个帮助你深入理解 GitHub 开源项目的智能助手。

## 功能

当你在学习或研究 GitHub 上的开源项目时，这个 skill 可以帮你：

1. **自动分析仓库结构** - 生成项目的目录结构和代码统计
2. **生成两份文档**：
   - **源码与原理解读** - 使用场景、优缺点、核心原理、设计思想、启发
   - **快速上手文档** - 安装、配置、运行步骤、常见问题
3. **自动复查机制** - 1 小时后自动复查，持续完善文档
4. **Mermaid 图表** - 自动生成架构图、流程图等可视化内容

## 使用方法

### 1. 准备工作

确保 GitHub 仓库已在本地：

```bash
cd ~/Documents/coding/github

# 如果仓库不存在，先克隆
git clone https://github.com/user/repo.git
```

### 2. 触发解读

发送 GitHub 链接给 AI，并明确说明需求：

- "帮我解读这个仓库的源码：https://github.com/user/repo"
- "分析一下这个项目的原理：https://github.com/user/repo"
- "生成这个项目的学习报告：https://github.com/user/repo"

### 3. 输出位置

解读文档会保存在：

```
~/Documents/working/github-analysis/<repo_name>/
├── <repo_name>_源码解读.md        # 深度分析报告
├── <repo_name>_快速上手.md        # 快速上手指南
├── structure.txt                   # 仓库结构
└── metadata.json                   # 元数据
```

## 文档结构

### 源码解读报告包含：

- **项目基本信息** - 仓库地址、技术栈、统计数据
- **使用场景** - 解决什么问题、适用场景
- **优点与缺点** - 客观分析
- **核心原理** - 整体架构、关键模块、数据流
- **设计思想** - 代码组织、设计模式、扩展性
- **对悟鸣的启发** - 结合岗位和研究的启发
- **Mermaid 图表** - 可视化架构和流程

### 快速上手文档包含：

- **环境要求** - 系统和依赖要求
- **安装步骤** - 克隆、安装、配置
- **快速体验** - 最小可运行示例
- **常见问题** - 安装和使用中的坑
- **下一步学习** - 推荐阅读的源码

## 特性

### 自动复查机制

初版完成后 1 小时，AI 会自动复查并完善文档：

- 补充遗漏的架构细节
- 优化使用场景描述
- 检查快速上手文档准确性
- 更新复查记录

### 个性化启发

结合悟鸣的背景（AI 应用、Agent 开发、工具链建设），提供：

- 当前岗位相关的启发
- 最近研究方向（Agent Skills、MCP）的结合
- 可应用到自己项目的具体建议

### Mermaid 图表

自动生成多种图表：

- 架构图 (`flowchart TD`)
- 模块关系图 (`flowchart LR`)
- 时序图 (`sequenceDiagram`)
- 类图 (`classDiagram`)

## 技术细节

### 工作流程

1. **解析仓库** - 从 GitHub URL 提取 owner 和 repo
2. **检查本地** - 确认仓库已在 `~/Documents/coding/github`
3. **创建分析目录** - 在 working 目录下创建对应文件夹
4. **分析结构** - 生成目录树和代码统计
5. **生成文档** - 创建解读报告和快速上手文档
6. **安排复查** - 设置 1 小时后的复查任务

### 辅助脚本

- **bootstrap_github_analysis.py** - 初始化分析环境
- **review.sh** - 复查任务辅助脚本

## 与其他 Skills 的关系

- **github-clone** - 克隆 GitHub 仓库（如果仓库不在本地）
- **article-interpreter** - 解读技术文章
- **paper-interpreter** - 解读学术论文
- **personal-secretary** - 获取悟鸣的背景信息

## 注意事项

1. **仓库规模** - 大型项目需要明确分析范围
2. **语言差异** - 根据项目语言调整分析重点
3. **版本选择** - 优先分析稳定版或主分支
4. **文档优先** - 先读官方文档，再读源码
5. **实践验证** - 快速上手文档建议实际运行验证

## 示例

### 输入

```
帮我解读这个项目的源码：https://github.com/vercel/next.js
```

### 输出

```
✓ 解析 GitHub 仓库: vercel/next.js
✓ 仓库已在本地: ~/Documents/coding/github/next.js
✓ 当前分支: canary
✓ 创建分析目录: ~/Documents/working/github-analysis/next.js
✓ 生成结构文件: structure.txt
✓ 生成元数据文件: metadata.json

开始解读 Next.js 的源码...
（生成解读报告和快速上手文档）
✓ 1 小时后的复查任务已安排

解读文档已保存到：
- ~/Documents/working/github-analysis/next.js/next.js_源码解读.md
- ~/Documents/working/github-analysis/next.js/next.js_快速上手.md
```

## 许可

MIT

---

作者：悟鸣
创建时间：2026-03-13
