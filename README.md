# fish-git-utils

[![Fisher plugin](https://img.shields.io/badge/Fisher-plugin-0098d7?style=flat&logo=fish)](https://github.com/jorgebucaran/fisher)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Lightweight Fish functions for Git cleanup.

- `git-prune-gone` — delete local branches whose upstream (remote) is gone.

## Install

With [Fisher](https://github.com/jorgebucaran/fisher)

```fish
fisher install chatter/fish-git-utils
```

## Usage

```fish
git-prune-gone [protected-branch-1] [protected-branch-2] ...
```

Deletes all local branches whose upstream no longer exists (e.g., origin/feature/xyz was deleted), excluding:
* the currently checked-out branch (always protected)
* any explicitly listed branches

## Example

```fish
git-prune-gone feature/login release/2025-Q3
```

This will delete all local branches with [gone] upstreams except main, develop, release/2025-Q3, and the currently active branch.

