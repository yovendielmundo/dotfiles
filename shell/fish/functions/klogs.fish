# Defined interactively
function klogs

    if kubectl get pods >/dev/null 2>&1
        set pod (kubectl get pods | awk '{if (NR!=1) print $1 ": \t[" $3 " " $2 "]"}' | fzf --height 40%)

        if set -q pod
            set pod_id (echo $pod | awk -F ': ' '{print $1}')

            kubectl logs --tail=50 "$pod_id" && kubectl logs --tail=1 -f "$pod_id" | jq -c . || kubectl logs --tail=1 -f "$pod_id"
        else
            echo "You haven't selected any pod! ༼つ◕_◕༽つ"
        end
    else
        echo "Kubectl is not connected! (ಠ_ಠ)"
    end

end
