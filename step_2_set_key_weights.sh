_NODE_ADDRESS=$(get_node_address_rpc)
_PATH_TO_CLIENT=$(get_path_to_client)
_SYSTEM_SECRET_KEY=$(get_path_to_secret_key "$NCTL_ACCOUNT_TYPE_FAUCET")
_SYSTEM_ACCOUNT_KEY=$(get_account_key "$NCTL_ACCOUNT_TYPE_FAUCET")
_SYSTEM_ACCOUNT_HASH=$(get_account_hash "$_SYSTEM_ACCOUNT_KEY")


function _set_key_weight_of_system()
{
    local WEIGHT=${1}
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
            --session-arg "$(get_cl_arg_string 'action' "set_key_weight")" \
            --session-arg "$(get_cl_arg_u8 'weight' "$WEIGHT")" \
            --session-arg "$(get_cl_arg_account_hash 'account' "$_SYSTEM_ACCOUNT_HASH")" \
            | jq '.result.deploy_hash' \
            | sed -e 's/^"//' -e 's/"$//'
        )
    
    echo "setting associated key weight for account A"
    echo "... weight = $WEIGHT"
    echo "... deploy-hash = $DEPLOY_HASH"
}

function _set_key_weight_of_user()
{
    local USER_ID=${1}
    local USER_KEY=${2}
    local WEIGHT=${3}

    local USER_ACCOUNT_KEY=$(get_account_key "$NCTL_ACCOUNT_TYPE_USER" "$USER_ID")
    local USER_ACCOUNT_HASH=$(get_account_hash "$USER_ACCOUNT_KEY")

    local PATH_TO_CONTRACT=$(get_path_to_contract "eco/keys-manager.wasm")

    DEPLOY_HASH=$(
        $_PATH_TO_CLIENT put-deploy \
            --chain-name "casper-net-1" \
            --gas-price "10" \
            --node-address "$_NODE_ADDRESS" \
            --payment-amount "10000000000000" \
            --ttl "1day" \
            --secret-key "$_SYSTEM_SECRET_KEY" \
            --session-path "$PATH_TO_CONTRACT" \
            --session-arg "$(get_cl_arg_string 'action' "set_key_weight")" \
            --session-arg "$(get_cl_arg_u8 'weight' "$WEIGHT")" \
            --session-arg "$(get_cl_arg_account_hash 'account' "$USER_ACCOUNT_HASH")" \
            | jq '.result.deploy_hash' \
            | sed -e 's/^"//' -e 's/"$//'
        )

    echo "-----------------------------------------------------------------------------------------------------------"
    echo "setting associated key weight for account $USER_KEY"
    echo "... weight = $WEIGHT"
    echo "... deploy-hash = $DEPLOY_HASH"
}

function _main()
{
    echo "-----------------------------------------------------------------------------------------------------------"

    # Set system key weight.
    _set_key_weight_of_system 50

    # Set user key weights.
    _set_key_weight_of_user 1 "B" 5
    _set_key_weight_of_user 2 "C" 10
    _set_key_weight_of_user 3 "D" 15

    echo "-----------------------------------------------------------------------------------------------------------"
}

_demo_set_contracts
_main
