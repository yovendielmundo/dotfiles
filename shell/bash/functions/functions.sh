wopen(){
	file_url=$1
	file_name="/tmp/$(basename -- $file_url)"
	wget -nv -O $file_name $file_url && open $file_name
}

jshell(){
  /usr/libexec/java_home --exec jshell
}

gpom(){
  git push origin master
}


into(){
  mkdir "$1" && cd "$1"
}


show-merchant(){
  echo $1 > /tmp/client_nonce | base64 -d /tmp/client_nonce | jq .
}

consul-template-run(){
  consul-template -consul-addr localhost:8500 -template "./application.yml.ctmpl:./application.yml" -once
}

kshell() {
  if kubectl get pods >/dev/null 2>&1; then
    pod=$(kubectl get pods | awk '{if (NR!=1) print $1 ": \t[" $3 " " $2 "]"}' | fzf --height 40%)

    if [[ -n $pod ]]; then
      pod_id=$(echo $pod | awk -F ': ' '{print $1}')

      kubectl exec --stdin --tty $pod_id -- /bin/bash || kubectl exec --stdin --tty $pod_id -- /bin/sh
    else
      echo "You haven't selected any pod! ༼つ◕_◕༽つ"
    fi
  else
    echo "Kubectl is not connected! (ಠ_ಠ)"
  fi
}


klogs() {
  if kubectl get pods >/dev/null 2>&1; then
    pod=$(kubectl get pods | awk '{if (NR!=1) print $1 ": \t[" $3 " " $2 "]"}' | fzf --height 40%)

    if [[ -n $pod ]]; then
      pod_id=$(echo $pod | awk -F ': ' '{print $1}')

      kubectl logs --tail=30 "$pod_id" && kubectl logs --tail=1 -f "$pod_id" | jq -c . || kubectl logs --tail=1 -f "$pod_id"
    else
      echo "You haven't selected any pod! ༼つ◕_◕༽つ"
    fi
  else
    echo "Kubectl is not connected! (ಠ_ಠ)"
  fi
}




kcontext() {
  if kubectl get pods >/dev/null 2>&1; then
    context=$(kubectl config get-contexts | awk '{if (NR!=1) print $3 ": \t[" $1 " " $2 "]"}' | fzf --height 40%)

    if [[ -n $context ]]; then
      context_id=$(echo $context | awk -F ': ' '{print $1}')

      kubectl config use-context "$context_id" && echo "༼つಠ益ಠ༽つ ─=≡ΣO)) HADOUKEN!!!"
    else
      echo "You haven't selected any context! ༼つ◕_◕༽つ"
    fi
  else
    echo "Kubectl is not connected! (ಠ_ಠ)"
  fi
}

kcopy() {
  if kubectl get pods >/dev/null 2>&1; then
    pod=$(kubectl get pods | awk '{if (NR!=1) print $1 ": \t\t[" $3 " " $2 "]"}' | fzf --height 40%)

    if [[ -n $pod ]]; then
      pod_id=$(echo "$pod" | awk -F ': ' '{print $1}')

      file=$(kubectl exec --stdin --tty "$pod_id" -- ls -Flah | fzf --height 40%)
      echo "You have selected $file"
    else
      echo "You haven't selected any pod! ༼つ◕_◕༽つ"
    fi
  else
    echo "Kubectl is not connected! (ಠ_ಠ)"
  fi
}

pretty-diff() {
  git -c color.status=always status --short |
    fzf --height 100% --ansi \
      --preview 'git diff HEAD --color=always -- {-1} | sed 1,4d' \
      --preview-window right:65% |
    cut -c4- |
    sed 's/.* -> //' |
    tr -d '\n' |
    pbcopy
}

mkdotfile() {
  file=$(ls -a | fzf --height 60%)

  if [[ -n $file ]]; then
    mv $file ~/.dotfiles/$file
    ln -s ~/.dotfiles/$file $PWD/$file
  else
    echo "You haven't selected any file! ༼つ◕_◕༽つ"
  fi
  
}

robo-3t() {
  if [[ -n $1 ]]; then
    QT_FONT_DPI=128 QT_SCALE_FACTOR=$1 /usr/local/Caskroom/robo-3t/1.4.3,48f7dfd/Robo\ 3T.app/Contents/MacOS/Robo\ 3T \
    || echo "You have choosen a wrong QT_SCALE_FACTOR=$1 ༼つ◕_◕༽つ"
  else
    QT_FONT_DPI=128 /usr/local/Caskroom/robo-3t/1.4.3,48f7dfd/Robo\ 3T.app/Contents/MacOS/Robo\ 3T
  fi
}



