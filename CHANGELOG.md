# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.2.0] - 2025-09-15

### Added
- New `git-clean-stale` function to delete branches older than specified time
  - Supports time formats like `3w` (3 weeks), `6m` (6 months), `1y` (1 year)
  - Auto-confirmation with `-y/--yes` flag
  - Cross-platform compatibility (macOS and Linux)
  - Protects current branch and worktree branches

### Fixed
- `git-prune-gone` now correctly skips branches checked out in worktrees
- `git-prune-gone` added `-y/--yes` flag for auto-confirmation

### Changed
- `git-prune-gone` improved to filter out worktree branches early in pipeline

## [0.1.0] - 2025-06-09

### Added
- Initial release with `git-prune-gone` function
- Deletes local branches whose upstream is gone
- Protects current branch and user-specified branches
- Interactive confirmation before deletion
- Fisher plugin support
- MIT License

[Unreleased]: https://github.com/chatter/fish-git-utils/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/chatter/fish-git-utils/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/chatter/fish-git-utils/releases/tag/v0.1.0