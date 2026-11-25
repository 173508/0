#!/bin/bash
# Fix Trailing Spaces
find . -name "*.md" -type f -print0 | xargs -0 sed -i 's/[[:space:]]*$//'
# Fix Tabs to Spaces
find . -name '*.md' ! -type d -exec bash -c 'expand -t 4 "$0" > /tmp/e && mv /tmp/e "$0"' {} \;
# Markup
echo
echo "-----------------------------------------"
echo "   Cleanup completed"
echo "-----------------------------------------"
echo
echo "Starting Tasks:"
echo
# Download the Latest Dr Dhu's macOs Security and Privacy Guide
echo " Update Dr Dhu's macOs Security and Privacy Guide ...."
echo
echo " Press Enter to update -"
read -r
wget -c -O Mac/Dr-Dhu-MacOs-Security-and-Privacy-Guide.md \
    https://github.com/drduh/macOS-Security-and-Privacy-Guide/raw/refs/heads/master/README.md
echo
echo " File updated."
echo
echo "-----------------------------------------"
echo "   Tasks completed"
echo "-----------------------------------------"
