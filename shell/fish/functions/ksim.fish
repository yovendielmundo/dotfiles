function ksim --description 'Kubectl set the image of selected deployment to master'

    if not kubectl get deployment >/dev/null 2>&1
        echo "Kubectl is not connected! (ಠ_ಠ)"
        return
    end

    set deployment (kubectl get deployment -o wide | awk '{if (NR!=1) print $1 " | " $6 " | " $7}' | fzf --height 40%)

    if not set -q deployment
        echo "You haven't selected any deployment! ༼つ◕_◕༽つ"
        return
    end

    set name (echo $deployment | awk -F ' \| ' '{print $1}')
    set container (echo $deployment | awk -F ' \| ' '{print $3}')
    set image (echo $deployment | awk -F ' \| ' '{print $5}' | awk -F ':' '{print $1}')

    echo "deployment:$name"
    echo "container:$container"
    echo "image:$image"
    kubectl set image deployment/$name $container=$image:master
#    echo "kubectl set image deployment/$name $container=$image:master"

end
