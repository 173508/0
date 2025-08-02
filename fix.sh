#!/bin/bash
# Fix Trailing Spaces
find . -name "*.md" -type f -print0 | xargs -0 sed -i 's/[[:space:]]*$//'
# Fix Tabs to Spaces
find . -name '*.md' ! -type d -exec bash -c 'expand -t 4 "$0" > /tmp/e && mv /tmp/e "$0"' {} \;
