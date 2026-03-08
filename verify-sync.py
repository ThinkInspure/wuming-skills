#!/usr/bin/env python3
"""
验证同步结果
检查 ~/.claude/skills 和 ~/.agents/skills 中的 skills
"""

import os
from pathlib import Path

skills = [
    "claudian-installer",
    "copaw-ops",
    "openclaw-ops",
    "openclaw-wiki",
    "prompt-optimizer",
    "qoder-wiki",
    "sync-skills"
]

targets = [
    Path.home() / ".claude" / "skills",
    Path.home() / ".agents" / "skills"
]

print("🔍 验证同步结果\n")
print("=" * 60)

for target in targets:
    print(f"\n📂 检查: {target}")
    print("-" * 60)

    if not target.exists():
        print(f"❌ 目录不存在: {target}")
        continue

    for skill_dir in skills:
        skill_path = target / skill_dir
        skill_file = skill_path / "SKILL.md"

        if skill_path.exists():
            # 检查 SKILL.md 文件
            if skill_file.exists():
                file_size = skill_file.stat().st_size
                print(f"  ✅ {skill_dir:25} - SKILL.md ({file_size} bytes)")
            else:
                print(f"  ⚠️  {skill_dir:25} - 缺少 SKILL.md")
        else:
            print(f"  ❌ {skill_dir:25} - 未同步")

print("\n" + "=" * 60)
print("✅ 验证完成！")
