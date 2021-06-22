function _main() 
{
    local NODE_ADDRESS=$(get_node_address_rpc node="1")
    local PATH_TO_CLIENT=$(get_path_to_client)
    local PATH_TO_CONTRACT_HASH="$_PATH_TO_DEMO/outputs/contract-hash"

    if [ -f "$PATH_TO_CONTRACT_HASH" ]; then
        rm "$PATH_TO_CONTRACT_HASH"
    fi

    log "querying chain ..."
    sleep 0.3

    local ACCOUNT_KEY=$(get_account_key "$NCTL_ACCOUNT_TYPE_FAUCET")
    local STATE_ROOT_HASH=$(get_state_root_hash)

    local _CONTRACT_HASH=$(
        $PATH_TO_CLIENT query-state \
            --node-address "$NODE_ADDRESS" \
            --state-root-hash "$STATE_ROOT_HASH" \
            --key "$ACCOUNT_KEY" \
            | jq '.result.stored_value.Account.named_keys[] | select(.name == "kvstorage_contract") | .key' \
            | sed -e 's/^"//' -e 's/"$//'  
    )

    cat >> "$PATH_TO_CONTRACT_HASH" <<- EOM
$_CONTRACT_HASH
EOM

    log "Stored contract hash = $_CONTRACT_HASH"
}

_main
