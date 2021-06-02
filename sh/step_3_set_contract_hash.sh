_NODE_ADDRESS=$(get_node_address_rpc)


function _main() 
{
    local PATH_TO_CONTRACT_HASH="$_PATH_TO_DEMO/assets/contract-hash"

    if [ -f "$PATH_TO_CONTRACT_HASH" ]; then
        rm "$PATH_TO_CONTRACT_HASH"
    fi

    local _ACCOUNT_KEY=$(get_account_key "$NCTL_ACCOUNT_TYPE_FAUCET")
    local _STATE_ROOT_HASH=$(get_state_root_hash)
    local _CONTRACT_HASH=$(
        $_PATH_TO_CLIENT query-state \
            --node-address "$_NODE_ADDRESS" \
            --state-root-hash "$_STATE_ROOT_HASH" \
            --key "$_ACCOUNT_KEY" \
            | jq '.result.stored_value.Account.named_keys[] | select(.name == "kvstorage_contract") | .key' \
            | sed -e 's/^"//' -e 's/"$//'  
    )

    cat >> "$PATH_TO_CONTRACT_HASH" <<- EOM
$_CONTRACT_HASH
EOM

    log "Stored contract hash = $_CONTRACT_HASH"
}

_main