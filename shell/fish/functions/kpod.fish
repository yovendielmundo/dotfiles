function kpod --description 'Select a pod' 
    if kubectl get pods >/dev/null 2>&1
        set pod (kubectl get pods | awk '{if (NR!=1) print $1 ": \t[" $3 " " $2 "]"}' | fzf --height 40%)

        if set -q pod
            echo $pod | awk -F ': ' '{print $1}' | pbcopy
        else
            echo "You haven't selected any pod! ༼つ◕_◕༽つ"
        end
    else
        echo "Kubectl is not connected! (ಠ_ಠ)"
    end

end
