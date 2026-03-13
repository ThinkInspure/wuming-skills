# 快速开始 - 3 分钟上手 GitHub 源码解读助手

## 准备工作（1 分钟）

### 1. 检查环境

```bash
# 检查 Python
python3 --version  # 需要 3.7+

# 检查 Git
git --version

# 检查 tree（可选）
tree --version  # 如果没有，可以安装：brew install tree
```

### 2. 准备 GitHub 仓库

```bash
cd ~/Documents/coding/github

# 如果项目还没克隆，先克隆
git clone https://github.com/user/repo.git
```

## 安装 Skill（30 秒）

```bash
npx skills add ~/Documents/coding/our/skills-wuming/skills/github-code-interpreter --global
```

## 使用（1 分钟）

### 方式 1：简单对话

发送消息给 AI：

```
帮我解读这个项目的源码：https://github.com/vercel/next.js
```

### 方式 2：更具体的需求

```
分析这个项目的路由系统设计：https://github.com/vercel/next.js
```

### 方式 3：聚焦某个模块

```
帮我理解 next.js 的渲染原理，仓库地址：https://github.com/vercel/next.js
```

## 查看结果

解读完成后，文档会保存在：

```
~/Documents/working/github-analysis/<repo_name>/
├── <repo_name>_源码解读.md    # 深度分析
├── <repo_name>_快速上手.md    # 快速指南
├── structure.txt              # 目录结构
└── metadata.json              # 元数据
```

## 常见问题

### Q1: 仓库不在本地怎么办？

**A**: AI 会提示你克隆，或者你可以先手动克隆：

```bash
cd ~/Documents/coding/github
git clone https://github.com/user/repo.git
```

### Q2: 想分析某个模块，不是整个项目？

**A**: 明确告诉 AI：

```
只分析 next.js 的路由系统，不要分析整个项目
```

### Q3: 项目太大，分析太慢？

**A**: 可以：

1. 聚焦某个模块
2. 或者耐心等待（大型项目确实需要时间）

### Q4: 不想要自动复查？

**A**: 可以在 SKILL.md 中删除复查相关部分，或者告诉 AI：

```
解读这个项目，但不需要安排复查
```

## 示例输出

### 成功的解读

```
✓ 解析 GitHub 仓库: vercel/next.js
✓ 仓库已在本地: ~/Documents/coding/github/next.js
✓ 当前分支: canary
✓ 创建分析目录: ~/Documents/working/github-analysis/next.js
✓ 生成结构文件: structure.txt
✓ 生成元数据文件: metadata.json

开始解读 Next.js 的源码...
（阅读 README、package.json、源码）
（生成两份文档）

✓ 解读完成！文档已保存到：
- ~/Documents/working/github-analysis/next.js/next.js_源码解读.md
- ~/Documents/working/github-analysis/next.js/next.js_快速上手.md

✓ 1 小时后的复查任务已安排

主要发现：
- Next.js 是一个 React 框架，提供 SSR、SSG、ISR 等功能
- 核心模块包括路由系统、渲染引擎、优化器等
- 代码量：TypeScript 1,138,627 行

对悟鸣的启发：
- 可以借鉴其插件系统设计到 Agent 开发
- 中间件机制与 MCP 的管道设计相似
- 模块化思想值得学习
```

## 下一步

1. **查看生成的文档**
   ```bash
   cat ~/Documents/working/github-analysis/<repo>/<repo>_源码解读.md
   ```

2. **根据快速上手文档实践**
   ```bash
   cat ~/Documents/working/github-analysis/<repo>/<repo>_快速上手.md
   ```

3. **等待复查完善**
   - 1 小时后 AI 会自动复查
   - 补充遗漏的内容
   - 优化文档质量

## 高级用法

### 批量分析多个项目

```
我想学习 React 生态，帮我解读这些项目：
1. https://github.com/facebook/react
2. https://github.com/vercel/next.js
3. https://github.com/vuejs/core
```

### 结合其他 Skills

```
解读这个项目：https://github.com/user/repo
然后用 article-interpreter 写一篇公众号文章介绍它
```

### 聚焦技术点

```
分析这个项目的并发处理机制：https://github.com/user/repo
重点关注：
1. 并发模型
2. 锁机制
3. 性能优化
```

## 获取帮助

如果遇到问题：

1. 查看 **README.md** - 详细功能介绍
2. 查看 **EXAMPLES.md** - 使用示例
3. 查看 **INSTALL.md** - 安装指南
4. 查看 **TESTING.md** - 已知问题

## 快捷命令

### 查看已分析的仓库

```bash
ls ~/Documents/working/github-analysis/
```

### 查看某个仓库的元数据

```bash
cat ~/Documents/working/github-analysis/<repo>/metadata.json | jq
```

### 手动触发复查

```bash
bash ~/.openclaw/skills/github-code-interpreter/scripts/review.sh \
  ~/Documents/working/github-analysis/<repo>
```

---

**准备好了吗？** 开始解读你的第一个 GitHub 项目吧！🚀

```
帮我解读这个项目的源码：[你的 GitHub 仓库链接]
```
