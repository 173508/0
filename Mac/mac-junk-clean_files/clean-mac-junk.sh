#!/usr/bin/env bash
set -euo pipefail

# macOS Junk Cleaner
# Removes .DS_Store, ._* resource forks, Icon\r, and other macOS metadata artifacts
# Usage: ./clean-mac-junk.sh [--force] [directory]

DRY_RUN=1
TARGET="${PWD}"

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --force) DRY_RUN=0; shift ;;
    -*) echo "Unknown flag: $1" >&2; exit 1 ;;
    *) TARGET="$1"; shift ;;
  esac
done

# Validate target directory
if [[ ! -d "$TARGET" ]]; then
  echo "Error: '$TARGET' is not a valid directory" >&2
  exit 1
fi

# Canonicalize path
TARGET="$(cd "$TARGET" && pwd)"

echo "=========================================="
echo "macOS Junk Cleaner"
echo "Target: $TARGET"
echo "=========================================="
[[ $DRY_RUN -eq 1 ]] && echo "DRY RUN (use --force to delete)" || echo "DELETING FILES (Ctrl+C to abort in 3 seconds)..."
echo "=========================================="
sleep 1

# Patterns to remove (files)
declare -a FILE_PATTERNS=(
  '.DS_Store'
  '.LSOverride'
  '._*'          # Resource fork files
  #'.apdisk'
  #'.VolumeIcon.icns'
  #'.background'
  #'.disk_label*'
  #'.metadata_never_index'
  #'.metadata_never_index_unless_rootfs'
  '.com.apple.timemachine.supported'
  '.com.apple.smb.streams.off'
  '.hotfiles.btree'
  '.journal_info_block'
  '.journal'
)

# Patterns to remove (directories)
declare -a DIR_PATTERNS=(
  '.AppleDouble'
  #'.Trashes'
  '.Spotlight-V100'
  '.TemporaryItems'
  #'.fseventsd'
)

# Special handling for Icon\r (carriage return in filename)
ICON_PATTERN=$'Icon\r'

# Helper function to execute or simulate deletion
delete_items() {
  local type="$1"  # "file" or "dir"
  local pattern="$2"
  local find_args=()

  case "$type" in
    file) find_args=(-type f) ;;
    dir)  find_args=(-type d) ;;
    *)    echo "Invalid type" >&2; exit 1 ;;
  esac

  while IFS= read -r -d '' item; do
    if [[ $DRY_RUN -eq 1 ]]; then
      echo "[DRY RUN] Would remove: $item"
    else
      echo "Removing: $item"
      if [[ "$type" == "dir" ]]; then
        rm -rf "$item" 2>/dev/null || echo "Warning: Failed to remove $item" >&2
      else
        rm -f "$item" 2>/dev/null || echo "Warning: Failed to remove $item" >&2
      fi
    fi
  done < <(find "$TARGET" -depth -name "$pattern" "${find_args[@]}" -print0 2>/dev/null || true)
}

# Process file patterns
for pat in "${FILE_PATTERNS[@]}"; do
  delete_items "file" "$pat"
done

# Special handling for Icon\r
delete_items "file" "$ICON_PATTERN"

# Process directory patterns (after files to avoid partial deletions)
for pat in "${DIR_PATTERNS[@]}"; do
  delete_items "dir" "$pat"
done

echo "=========================================="
if [[ $DRY_RUN -eq 1 ]]; then
  echo "Dry run complete. Use '--force' to delete files."
else
  echo "Cleanup complete!"
fi
echo "=========================================="
