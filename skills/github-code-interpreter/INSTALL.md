# GitHub 源码解读助手 - 安装和使用指南

## 安装 Skill

### 方法 1：使用 npx skills add（推荐）

```bash
npx skills add ~/Documents/coding/our/skills-wuming/skills/github-code-interpreter --global
```

这会将 skill 安装到以下位置（符号链接）：
- `~/.agents/skills/github-code-interpreter`
- `~/.claude/skills/github-code-interpreter`
- `~/.openclaw/skills/github-code-interpreter`

### 方法 2：手动创建符号链接

```bash
# 创建到 OpenClaw skills 目录
ln -s ~/Documents/coding/our/skills-wuming/skills/github-code-interpreter \
   ~/.openclaw/skills/github-code-interpreter

# 创建到 Claude skills 目录（如果存在）
ln -s ~/Documents/coding/our/skills-wuming/skills/github-code-interpreter \
   ~/.claude/skills/github-code-interpreter

# 创建到 agents skills 目录
ln -s ~/Documents/coding/our/skills-wuming/skills/github-code-interpreter \
   ~/.agents/skills/github-code-interpreter
```

## 验证安装

### 1. 检查 skill 是否存在

```bash
ls -la ~/.openclaw/skills/ | grep github-code
```

应该看到：
```
github-code-interpreter -> /Users/liuwangyang/Documents/coding/our/skills-wuming/skills/github-code-interpreter
```

### 2. 检查文件结构

```bash
ls -la ~/.openclaw/skills/github-code-interpreter/
```

应该看到：
```
SKILL.md
README.md
EXAMPLES.md
skill.json
scripts/
  bootstrap_github_analysis.py
  review.sh
references/
  report-outline.md
```

### 3. 测试脚本

```bash
# 测试初始化脚本
python3 ~/.openclaw/skills/github-code-interpreter/scripts/bootstrap_github_analysis.py \
  https://github.com/openclaw/openclaw \
  ~/Documents/working/tmp
```

应该看到成功输出。

## 使用 Skill

### 基本用法

在对话中发送 GitHub 链接，并明确需求：

```
帮我解读这个项目的源码：https://github.com/user/repo
```

### 支持的触发词

- "解读源码"
- "源码解读"
- "分析源码"
- "理解原理"
- "生成学习报告"
- "github解读"
- "仓库分析"

### 示例对话

#### 示例 1：完整解读

```
用户: 帮我解读这个项目的源码：https://github.com/vercel/next.js

AI: ✓ 解析 GitHub 仓库: vercel/next.js
    ✓ 仓库已在本地
    ✓ 创建分析目录
    ✓ 生成结构文件
    ✓ 生成元数据文件

    开始解读 Next.js 的源码...
    （阅读 README、package.json、源码）
    （生成两份文档）

    ✓ 解读完成！文档已保存到：
    - ~/Documents/working/github-analysis/next.js/next.js_源码解读.md
    - ~/Documents/working/github-analysis/next.js/next.js_快速上手.md

    ✓ 1 小时后的复查任务已安排
```

#### 示例 2：聚焦某个模块

```
用户: 分析 next.js 的路由系统设计

AI: 好的，我会聚焦分析 Next.js 的路由系统。
    （重点分析路由相关的代码）
    （生成针对性的解读报告）
```

#### 示例 3：仓库不在本地

```
用户: 解读这个项目：https://github.com/user/new-repo

AI: ✗ 仓库不在本地
    需要先克隆仓库：
    git clone https://github.com/user/new-repo.git

    是否需要我帮你克隆？
```

## 配置选项

### 自定义输出目录

默认使用 `~/Documents/working/github-analysis/`，可以在 SKILL.md 中修改。

### 自定义复查间隔

默认 1 小时后复查，可以在 SKILL.md 中修改。

### 禁用自动复查

如果不想要自动复查，可以在 SKILL.md 中删除相关部分。

## 故障排查

### 问题 1：Skill 未被识别

**症状**：发送 GitHub 链接时 AI 没有触发这个 skill

**解决方法**：

1. 检查 SKILL.md 中的 description 是否正确
2. 检查 skill 是否在正确的目录
3. 重启 AI 会话
4. 检查 skill.json 中的 trigger 配置

### 问题 2：脚本执行失败

**症状**：初始化脚本报错

**解决方法**：

1. 检查 Python 版本（需要 3.7+）
   ```bash
   python3 --version
   ```

2. 检查是否有 tree 命令
   ```bash
   which tree
   # 如果没有，安装：
   brew install tree  # macOS
   ```

3. 检查文件权限
   ```bash
   chmod +x scripts/*.sh
   ```

### 问题 3：仓库路径错误

**症状**：找不到 GitHub 仓库

**解决方法**：

1. 检查仓库是否在 `~/Documents/coding/github/` 下
2. 如果在其他目录，修改 SKILL.md 中的路径
3. 或者先克隆仓库到正确位置

### 问题 4：文档生成不完整

**症状**：生成的文档缺少某些部分

**解决方法**：

1. 查看错误日志
2. 手动补充缺失部分
3. 等待复查任务自动完善
4. 检查源码是否有 README 等文档

## 高级用法

### 1. 批量解读多个仓库

创建一个脚本批量处理：

```bash
#!/bin/bash
repos=(
  "https://github.com/vercel/next.js"
  "https://github.com/facebook/react"
  "https://github.com/vuejs/core"
)

for repo in "${repos[@]}"; do
  echo "解读 $repo ..."
  # 通过某种方式触发 skill
done
```

### 2. 集成到工作流

```bash
# 学习某个技术栈时
echo "我想学习 React 框架，帮我解读这些项目..."
echo "1. https://github.com/facebook/react"
echo "2. https://github.com/vercel/next.js"
echo "3. https://github.com/facebook/react-native"
```

### 3. 结合其他 Skills

```
用户: 解读这个项目：https://github.com/user/repo
       然后用 article-interpreter 写一篇介绍文章

AI: （先运行 github-code-interpreter）
    （然后运行 article-interpreter）
    ✓ 完成！已生成解读报告和公众号文章
```

## 更新 Skill

如果更新了 skill 文件：

```bash
# 重新安装
npx skills add ~/Documents/coding/our/skills-wuming/skills/github-code-interpreter --force --global
```

或者直接修改文件（因为是符号链接，会立即生效）。

## 卸载 Skill

```bash
npx skills remove github-code-interpreter --global
```

或手动删除符号链接：

```bash
rm ~/.openclaw/skills/github-code-interpreter
rm ~/.claude/skills/github-code-interpreter
rm ~/.agents/skills/github-code-interpreter
```

## 反馈和改进

如果遇到问题或有改进建议：

1. 查看日志文件
2. 检查生成的 metadata.json
3. 手动运行脚本测试
4. 联系开发者（悟鸣）

## 相关资源

- **GitHub 仓库**：（如果有）
- **文档**：README.md、EXAMPLES.md
- **报告模板**：references/report-outline.md
- **其他 Skills**：
  - github-clone：克隆 GitHub 仓库
  - article-interpreter：解读技术文章
  - paper-interpreter：解读学术论文

---

祝使用愉快！🚀
