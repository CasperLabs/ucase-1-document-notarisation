
function _main()
{
    local NODE_ADDRESS=$(get_node_address_rpc node="1")
    local PATH_TO_CLIENT=$(get_path_to_client)
    local STATE_ROOT_HASH=$(get_state_root_hash)
    local CONTRACT_HASH=$(cat "$_PATH_TO_DEMO/outputs/contract-hash")

    $PATH_TO_CLIENT query-state \
        -k "$CONTRACT_HASH" \
        -n "$NODE_ADDRESS" \
        -s "$STATE_ROOT_HASH"    
}

_main
