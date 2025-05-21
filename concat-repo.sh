#!/usr/bin/env bash
#
# concat.sh  [root-dir] [output-file]
#
# Squashes a whole codebase into one text file, skipping build artifacts:
#   • ignores node_modules, dist, .git, .turbo, .next, out
#   • omits lockfiles and *.min.* noise
#   • copies the result straight to the macOS clipboard (pbcopy)
#
# Example:
#   bash concat.sh ~/Projects/notarium-mcp mega.txt
#

root="${1:-.}"
out="${2:-bigcode.txt}"

# fresh file
> "$out"

# ----------- find everything we want (and nothing we don’t) -------------
find "$root" \
  \( -type d \( \
        -name node_modules -o -name dist -o -name .git -o -name .turbo -o -name .next -o -name out \
     \) -prune \) -o \
  \( -type f \
     \(  -name '*.js'  -o -name '*.ts'  -o -name '*.tsx' -o -name '*.jsx' \
     -o -name '*.py'  -o -name '*.json' -o -name '*.md'  -o -name '*.txt' \
     -o -name '*.css' -o -name '*.html' -o -name '*.scss' \
     -o -name '*.swift' -o -name '*.plist' -o -name '*.entitlements' \)
     ! \( -name 'package-lock.json' -o -name 'yarn.lock' -o -name 'pnpm-lock.yaml' \
     -o -name '*.min.js' -o -name '*.min.css' \) \
     -print \
  \) |
while IFS= read -r file; do
  printf '### %s ###\n' "$file" >>"$out"
  cat "$file"                    >>"$out"
  printf '\n\n'                  >>"$out"
done
# ------------------------------------------------------------------------

lines=$(wc -l <"$out")
echo "🟢 wrote $lines lines to $out"

# copy to clipboard on macOS
if command -v pbcopy >/dev/null 2>&1; then
  pbcopy <"$out"
  echo "📋 copied to clipboard"
fi
