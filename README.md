# fish-git-utils

[![Fisher plugin](https://img.shields.io/badge/Fisher-plugin-0098d7?style=flat&logo=fish)](https://github.com/jorgebucaran/fisher)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Lightweight Fish functions for Git cleanup.

- `git-prune-gone` — delete local branches whose upstream (remote) is gone
- `git-clean-stale` — delete local branches older than specified time

## Install

With [Fisher](https://github.com/jorgebucaran/fisher)

```fish
fisher install chatter/fish-git-utils
```

## Usage

### git-prune-gone

```fish
git-prune-gone [-y|--yes] [protected-branch-1] [protected-branch-2] ...
```

Deletes all local branches whose upstream no longer exists (e.g., origin/feature/xyz was deleted), excluding:
* The currently checked-out branch (always protected)
* Branches checked out in worktrees (always protected)
* Any explicitly listed branches

Options:
- `-y, --yes` — Skip confirmation prompt

### git-clean-stale

```fish
git-clean-stale [-y|--yes] <age> [protected-branch-1] [protected-branch-2] ...
```

Deletes all local branches that haven't been updated in the specified time period, excluding:
* The currently checked-out branch (always protected)
* Branches checked out in worktrees (always protected)
* Any explicitly listed branches

Options:
- `-y, --yes` — Skip confirmation prompt

Time formats:
- `3w` — 3 weeks
- `6m` — 6 months
- `1y` — 1 year

## Examples

```fish
# Delete branches with gone upstreams, protecting feature/login
git-prune-gone feature/login

# Auto-confirm deletion of branches with gone upstreams
git-prune-gone -y

# Delete branches older than 3 weeks
git-clean-stale 3w

# Delete branches older than 6 months, protecting release branches
git-clean-stale -y 6m release/2025-Q3 release/2025-Q4
```

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history.

