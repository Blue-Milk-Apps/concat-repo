# concat-repo
Squashes a whole codebase into one text file, skipping build artifacts, and copies it right into the clipboard.

# Usage
concat-repo.sh  [root-dir] [output-file]

Squashes a whole codebase into one text file, skipping build artifacts:
- ignores node_modules, dist, .git, .turbo, .next, out
- omits lockfiles and *.min.* noise
- copies the result straight to the macOS clipboard (pbcopy)

Example:
bash concat.sh ~/Projects/notarium-mcp mega.txt
