function fkl --description 'Fuzzy keybase chat list and read' 

    keybase chat list \
        | fzf --height 50% \
        | awk '{print $2}' \
        | xargs keybase chat read $1

end