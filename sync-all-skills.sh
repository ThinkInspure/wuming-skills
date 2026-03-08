#!/bin/bash
# Sync all skills from current repository to all AI coding tool directories

set -euo pipefail

SOURCE_DIR="/Users/liuwangyang/Documents/coding/our/skills"

# All target directories to check
TARGET_DIRS=(
  "$HOME/.claude/skills"
  "$HOME/.qoder/skills"
  "$HOME/.copilot/skills"
  "$HOME/.gemini/antigravity/skills"
  "$HOME/.cursor/skills"
  "$HOME/.config/opencode/skill"
  "$HOME/.codex/skills"
  "$HOME/.gemini/skills"
  "$HOME/.codeium/windsurf/skills"
  "$HOME/.qwen/skills"
  "$HOME/.openclaw/skills"
)

# Get existing target directories
get_existing_targets() {
  local existing=()
  for target in "${TARGET_DIRS[@]}"; do
    if [ -d "$target" ]; then
      existing+=("$target")
    fi
  done
  echo "${existing[@]}"
}

# List existing targets and ask for confirmation
confirm_sync() {
  local existing_targets=("$@")

  if [ ${#existing_targets[@]} -eq 0 ]; then
    echo "❌ No target directories found."
    exit 1
  fi

  echo "📋 Found ${#existing_targets[@]} existing target directory(s):"
  echo ""
  for i in "${!existing_targets[@]}"; do
    echo "  $((i+1)). ${existing_targets[$i]}"
  done
  echo ""
  read -p "✅ Sync to these directories? (y/N): " confirm

  if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "❌ Sync cancelled by user."
    exit 1
  fi
}

# Sync skills to a target directory
sync_to_target() {
  local target="$1"
  echo "  → Syncing to $target..."

  # Find all skill directories
  for skill_dir in "$SOURCE_DIR"/skills/*/; do
    if [ -d "$skill_dir" ]; then
      skill_name=$(basename "$skill_dir")
      echo "    - Syncing $skill_name..."

      # Remove existing skill if it exists
      if [ -d "$target/$skill_name" ]; then
        rm -rf "$target/$skill_name"
      fi

      # Copy skill directory
      cp -r "$skill_dir" "$target/"
    fi
  done
}

main() {
  echo "🚀 Syncing all skills from $SOURCE_DIR"
  echo ""

  # Get existing targets
  existing_targets=($(get_existing_targets))

  # Confirm with user
  confirm_sync "${existing_targets[@]}"

  echo ""
  echo "🔄 Starting sync..."
  echo ""

  # Sync to each target
  for target in "${existing_targets[@]}"; do
    sync_to_target "$target"
  done

  echo ""
  echo "✅ Sync complete!"
}

main "$@"
