function showmerchant --description 'Show GWT token to use in the Frontend braintree API' 

    if not string length -q -- "$argv[1]"
        echo "There is not argument... using pbpaste(clipboard)"
        pbpaste > /tmp/client_nonce && base64 -d /tmp/client_nonce | jq .
    else
        set -l token $argv[1]
        echo $token > /tmp/client_nonce && base64 -d /tmp/client_nonce | jq .
    end
    
end