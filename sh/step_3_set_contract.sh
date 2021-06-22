function _main() 
{
    local NODE_ADDRESS=$(get_node_address_rpc node="1")
    local PATH_TO_CLIENT=$(get_path_to_client)
    local PATH_TO_CONTRACT="$_PATH_TO_DEMO/assets/contract_kv_storage.wasm"
    local SYSTEM_SECRET_KEY=$(get_path_to_secret_key "$NCTL_ACCOUNT_TYPE_FAUCET")

    DEPLOY_HASH=$(
        $PATH_TO_CLIENT put-deploy \
            --chain-name "casper-net-1" \
            --gas-price "10" \
            --node-address "$NODE_ADDRESS" \
            --payment-amount "10000000000000" \
            --ttl "1day" \
            --secret-key "$SYSTEM_SECRET_KEY" \
            --session-path "$PATH_TO_CONTRACT" \
            | jq '.result.deploy_hash' \
            | sed -e 's/^"//' -e 's/"$//'
        )

    echo "-----------------------------------------------------------------------------------------------------------"
    echo "installing contract -> kv_storage.wasm"
    echo "... path = $PATH_TO_CONTRACT"
    echo "... deploy hash = $DEPLOY_HASH"
    echo "-----------------------------------------------------------------------------------------------------------"
}

_main
