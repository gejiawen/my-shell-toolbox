#!/usr/bin/env bash

git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch package-lock.json site/package-lock.json' --prune-empty --tag-name-filter cat -- --all
rm -rf .git/refs/original/
git reflog expire --expire=now --all
git gc --prune=now
git gc --aggressive --prune=now
git push origin --force

echo '----- update local -----'
git pull -p
