_NODE_ADDRESS=$(get_node_address_rpc)
_PATH_TO_CLIENT=$(get_path_to_client)


function _main()
{
    local PATH_TO_DEPLOY="$_PATH_TO_DEMO/assets/deploy-2.json"

    DEPLOY_HASH=$(cat "$PATH_TO_DEPLOY" | jq '.hash' | sed -e 's/^"//' -e 's/"$//')

    $_PATH_TO_CLIENT send-deploy \
        --input "$PATH_TO_DEPLOY" \
        --node-address "$_NODE_ADDRESS" \
        > /dev/null 2>&1

    log "dispatched signed deploy 2:"
    log "... deploy-hash = $DEPLOY_HASH"
}

_main
