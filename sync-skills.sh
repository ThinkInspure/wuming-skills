#!/bin/bash

# Skills 同步脚本
# 将 skills 文件夹中的所有 skill 同步到 ~/.claude/skills 和 ~/.agents/skills

# 获取所有 skill 目录
skills=("claudian-installer" "copaw-ops" "openclaw-ops" "openclaw-wiki" "prompt-optimizer" "qoder-wiki" "sync-skills")

# 目标目录
targets=("$HOME/.claude/skills" "$HOME/.agents/skills")

echo "🚀 开始同步 skills..."
echo ""

for target in "${targets[@]}"; do
    echo "📂 同步到: $target"

    # 确保目标目录存在
    mkdir -p "$target"

    for skill_dir in "${skills[@]}"; do
        echo "  处理: $skill_dir"

        # 删除已存在的 skill
        if [ -d "$target/$skill_dir" ]; then
            echo "    🗑️  删除已存在的: $target/$skill_dir"
            rm -rf "$target/$skill_dir"
        fi

        # 复制 skill
        if [ -d "skills/$skill_dir" ]; then
            echo "    📋 复制 skills/$skill_dir"
            cp -r "skills/$skill_dir" "$target/"
            echo "    ✅ 完成: $skill_dir"
        else
            echo "    ⚠️  跳过: skills/$skill_dir (不存在)"
        fi
    done

    echo ""
    echo "✅ 已完成同步到: $target"
    echo ""
done

echo "🎉 所有 skills 同步完成！"
echo ""
echo "已同步的 skills:"
for skill_dir in "${skills[@]}"; do
    echo "  - $skill_dir"
done
