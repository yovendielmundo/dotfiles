_docker_compose(){
  docker-compose -f ~/dev/packlink/bootstrap/docker-compose/$1 ${@:2}
}

microservices(){
   _docker_compose "microservices.yml" "$@"
}

infrastructure(){
  _docker_compose "infrastructure.yml" "$@"
}

wopen(){
	file_url=$1
	file_name="/tmp/$(basename -- $file_url)"
	wget -nv -O $file_name $file_url && open $file_name
}

jshell(){
  /usr/libexec/java_home --exec jshell
}

grau(){
  gra upstream $(git config --local --get remote.origin.url | sed 's/yovendielmundo/packlink-dev/g')
}

gpom(){
  git push origin master
}


into(){
  mkdir "$1" && cd "$1"
}


show-merchant(){
  echo $1 | base64 -Dd - | jq .
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

      kubectl logs --tail=20 $pod_id && kubectl logs --tail=1 -f $pod_id | jq -c . || kubectl logs --tail=1 -f $pod_id 
    else
      echo "You haven't selected any pod! ༼つ◕_◕༽つ"
    fi
  else
    echo "Kubectl is not connected! (ಠ_ಠ)"
  fi
}

config-apply() {

  cd ~/dev/packlink/k8s-manifests/

  is_up_to_date=$(git fetch --dry-run)

  if [[ -n $is_up_to_date ]]; then
    git checkout master && git remote update && git pull upstream master || echo "There is a problem with the repo ༼つ◕_◕༽つ"
  else
    echo "Repo up to date! (ಠ_ಠ)" 
  fi

  ./helpers/configctl.sh ${@:1}
}


pretty-diff() {
  if (! git::is_in_repo); then
    echo "Not in a git repo!"
    exit 0
  fi

  git -c color.status=always status --short |
    fzf --height 100% --ansi \
      --preview '(git diff HEAD --color=always -- {-1} | sed 1,4d)' \
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

