_NODE_ADDRESS=$(get_node_address_rpc)
_PATH_TO_CLIENT=$(get_path_to_client)
_SYSTEM_SECRET_KEY=$(get_path_to_secret_key "$NCTL_ACCOUNT_TYPE_FAUCET")


function _set_action_threshold()
{
    local ACTION_TYPE=${1}
    local ACTION_WEIGHT=${2}
    local ACTION="set_$ACTION_TYPE""_threshold"
    local PATH_TO_CONTRACT="$_PATH_TO_DEMO/assets/contract-keys-manager.wasm"

    DEPLOY_HASH=$(
        $_PATH_TO_CLIENT put-deploy \
            --chain-name "casper-net-1" \
            --gas-price "10" \
            --node-address "$_NODE_ADDRESS" \
            --payment-amount "10000000000000" \
            --ttl "1day" \
            --secret-key "$_SYSTEM_SECRET_KEY" \
            --session-path "$PATH_TO_CONTRACT" \
            --session-arg "$(get_cl_arg_string 'action' "$ACTION")" \
            --session-arg "$(get_cl_arg_u8 'weight' "$ACTION_WEIGHT")" \
            | jq '.result.deploy_hash' \
            | sed -e 's/^"//' -e 's/"$//'
        )
    
    echo "setting action threshold for $ACTION_TYPE:"
    echo "... weight = $ACTION_WEIGHT"
    echo "... deploy-hash = $DEPLOY_HASH"
}


function _main()
{
    echo "-----------------------------------------------------------------------------------------------------------"
    _set_action_threshold "key_management" 50
    echo "-----------------------------------------------------------------------------------------------------------"
    _set_action_threshold "deployment" 30
    echo "-----------------------------------------------------------------------------------------------------------"
}

_demo_set_contracts
_main
