

function _main()
{
    local NODE_ADDRESS=$(get_node_address_rpc)
    local PATH_TO_CLIENT=$(get_path_to_client)
    local PATH_TO_DEPLOY="$_PATH_TO_DEMO/assets/deploy-1.json"

    DEPLOY_HASH=$(cat "$PATH_TO_DEPLOY" | jq '.hash' | sed -e 's/^"//' -e 's/"$//')

    $PATH_TO_CLIENT send-deploy \
        --input "$PATH_TO_DEPLOY" \
        --node-address "$NODE_ADDRESS" \
        > /dev/null 2>&1

    log "dispatched signed deploy 1:"
    log "... deploy-hash = $DEPLOY_HASH"
}

_main
