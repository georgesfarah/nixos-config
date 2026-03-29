#!/usr/bin/env bash
# Shell cheatsheet — curated from history, safe to copy to new VMs
# Georges Farah — dd-source monorepo

# ─── Git ────────────────────────────────────────────────────────────────────

git status
git log
git fetch origin main
git pull origin main
git checkout main
git checkout -b <branch>
git checkout -                        # switch to previous branch
git push
git push --force-with-lease           # safer force push
git commit --amend
git reset --soft HEAD~1               # undo last commit, keep changes staged
git reset --hard HEAD                 # discard all local changes
git rebase origin/main
git rebase origin/main -i
git rebase <base-branch>
git stash
git stash apply
git cherry-pick <sha>
git branch -D <branch>

# ─── Bazel (bzl) ─────────────────────────────────────────────────────────────

bzl version
bzl build //<target>
bzl test //<target>
bzl run //<target>
bzl query '<query>'
bzl clean --expunge

# Gazelle (update BUILD files after editing .go / .py / .proto)
bzl run //:gazelle
bzl run //:gazelle -- <path>          # scope to specific directory

# Snapshot (regenerate proto generated code)
bzl run //:snapshot -- //<path>/...

# Vendor Rust crates
bzl run //third_party:crates_vendor

# Run tests with code coverage
bzl test \
  --collect_code_coverage \
  --combined_report=lcov \
  //<target>

# Coverage shorthand
bzl coverage //<target> --combined_report=lcov

# Query target types
bzl query 'kind("go_test", //...)'

# ─── Rust / Cargo ────────────────────────────────────────────────────────────

cargo test -p <package>
cargo package
cargo package --workspace

# SSH into a workspace
ssh workspace-<name>

# ─── Homebrew ────────────────────────────────────────────────────────────────

brew update && brew upgrade
brew update && brew upgrade <tool>

# ─── Auth / GitHub ───────────────────────────────────────────────────────────

gh auth login

# ─── Claude Code ─────────────────────────────────────────────────────────────

claude
claude --resume                       # resume last conversation
claude --resume <conversation-id>

# ─── Misc ────────────────────────────────────────────────────────────────────

kill <pid>
