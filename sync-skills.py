#!/usr/bin/env python3
"""
Skills 同步脚本
将 skills 文件夹中的所有 skill 同步到 ~/.claude/skills 和 ~/.agents/skills
"""

import os
import shutil
from pathlib import Path

# 获取所有 skill 目录
skills = [
    "claudian-installer",
    "copaw-ops",
    "openclaw-ops",
    "openclaw-wiki",
    "prompt-optimizer",
    "qoder-wiki",
    "sync-skills"
]

# 目标目录
targets = [
    Path.home() / ".claude" / "skills",
    Path.home() / ".agents" / "skills"
]

def sync_skills():
    """同步所有 skills 到目标目录"""
    print("🚀 开始同步 skills...\n")

    for target in targets:
        print(f"📂 同步到: {target}")

        # 确保目标目录存在
        target.mkdir(parents=True, exist_ok=True)

        for skill_dir in skills:
            source_path = Path("skills") / skill_dir
            target_path = target / skill_dir

            print(f"  处理: {skill_dir}")

            # 检查源目录是否存在
            if not source_path.exists():
                print(f"    ⚠️  跳过: {source_path} (不存在)")
                continue

            # 删除已存在的 skill
            if target_path.exists():
                print(f"    🗑️  删除已存在的: {target_path}")
                shutil.rmtree(target_path)

            # 复制 skill
            print(f"    📋 复制 {source_path}")
            shutil.copytree(source_path, target_path)
            print(f"    ✅ 完成: {skill_dir}")

        print(f"\n✅ 已完成同步到: {target}\n")

    print("🎉 所有 skills 同步完成！\n")
    print("已同步的 skills:")
    for skill_dir in skills:
        print(f"  - {skill_dir}")

if __name__ == "__main__":
    sync_skills()
