function kwatch --description 'Watch a pod' 
    if kubectl get pods >/dev/null 2>&1
        set -l deploy $argv[1]
        if set -q deploy
            watch "kubectl get pods | awk 'NR==1 || /^$deploy/'"
        else
            echo "You haven't type any deploy! ༼つ◕_◕༽つ"
        end
    else
        echo "Kubectl is not connected! (ಠ_ಠ)"
    end
end