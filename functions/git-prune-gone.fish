# POTENTIAL FUTURE ITEMS:
# 1 flag to ignore branches not merged into a specific branch
# 2 --dry-run just to see what it'd delete
# 
# Usage: git-prune-gone [-y|--yes] [protected_branch ...]
function git-prune-gone
  echo "Fetching latest remote branches..."
  argparse -n git-prune-gone 'y/yes' -- $argv
  or return

  git fetch --prune

  set gone_branches (
    git branch -vv | grep -v '^+' | awk '/: gone]/{print $1}' |
    sed 's/^\*//' |
    string trim |
    string match -rv '^$'
  )

  if test (count $gone_branches) -eq 0
    echo "No local branches with gone remotes found."
    return
  end

  # Read protected branches from args
  set protected_branches $argv
  set current_branch (git symbolic-ref --short HEAD)
  set protected_branches $protected_branches $current_branch

  # Filter out protected branches
  for p in $protected_branches
    set gone_branches (string match -v $p $gone_branches)
  end

  if not string length -q $gone_branches
    echo "All gone branches are protected. Nothing to delete."
    return
  end

  echo "Branches with gone upstreams:"
  for b in $gone_branches
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
      for b in $gone_branches
          git branch -D $b
      end
      echo "Deleted branches."
    case '*'
      echo "Aborted."
  end
end
