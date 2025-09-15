function git-clean-stale
  set -l usage "Usage: git-clean-stale [-y|--yes] <age> [protected-branch ...]\nExample: git-clean-stale 3w main dev"
  
  argparse -n git-clean-stale 'y/yes' -- $argv
  or return
  
  if test (count $argv) -lt 1
    echo $usage
    return 1
  end

  set -l since $argv[1]
  set -e argv[1]

  # Convert "3w", "6m", "1y" into `--since` format
  set -l now (date -u "+%s")
  
  # Try BSD/macOS date first, then GNU/Linux date
  set -l ago (date -u -v -$since "+%s" 2>/dev/null)
  if test -z "$ago"
    # Try GNU date format (Linux)
    set ago (date -u -d "$since ago" "+%s" 2>/dev/null)
  end
  
  if test -z "$ago"
    echo "Invalid time format: '$since'"
    echo $usage
    return 1
  end
  set -l since_arg "--since=$since"

  echo "Fetching latest..."
  git fetch --prune

  set -l protected_branches $argv
  set -l current_branch (git symbolic-ref --short HEAD)
  set -l protected_branches $protected_branches $current_branch
  
  # Get branches that are checked out in worktrees
  set -l worktree_branches (git branch -vv | grep '^+' | awk '{print $2}')
  set -l protected_branches $protected_branches $worktree_branches

  set -l stale_branches

  for branch in (git for-each-ref --format='%(refname:short)' refs/heads/)
    if contains $branch $protected_branches
      continue
    end

    set -l last_commit (git log -1 --format=%ct $branch)
    if test -z "$last_commit"
      continue
    end

    if test $last_commit -lt $ago
      set stale_branches $stale_branches $branch
    end
  end

  if test (count $stale_branches) -eq 0
    echo "No stale branches older than $since."
    return
  end

  echo "Branches not updated since $since:"
  for b in $stale_branches
    echo "  $b"
  end

  if set -q _flag_y
    set confirm y
  else
    printf "Delete these branches? Type 'y' to confirm:\n"
    read confirm
  end

  switch $confirm
    case y Y
      for b in $stale_branches
        git branch -D $b
      end
      echo "Deleted stale branches."
    case '*'
      echo "Aborted."
  end
end
