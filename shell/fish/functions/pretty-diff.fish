function pretty-diff --description 'Git diff in a pretty way' 
#  if (! git::is_in_repo); then
#    echo "Not in a git repo!"
#    exit 0
#  fi
  git -c color.status=always status --short |
    fzf --height 100% --ansi \
      --preview 'git diff HEAD --color=always -- {-1} | sed 1,4d' \
      --preview-window right:65% |
    cut -c4- |
    sed 's/.* -> //' |
    tr -d '\n' |
    pbcopy
end