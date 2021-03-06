function _main()
{
    local CONTRACT_HASH=$(cat $_PATH_TO_DEMO/outputs/contract-hash)
    local DOCUMENT_CHECKSUM=$(cat $_PATH_TO_DEMO/outputs/document-checksum)
    local DOCUMENT_METADATA=$(cat $_PATH_TO_DEMO/outputs/document-metadata)
    local PATH_TO_CLIENT=$(get_path_to_client)
    local PATH_TO_DEPLOY="$_PATH_TO_DEMO/outputs/notarisation-2.json"
    local USER1_SECRET_KEY=$(get_path_to_secret_key "$NCTL_ACCOUNT_TYPE_USER" "1")
    local USER2_SECRET_KEY=$(get_path_to_secret_key "$NCTL_ACCOUNT_TYPE_USER" "2")

    $PATH_TO_CLIENT make-deploy \
        --output "$PATH_TO_DEPLOY" \
        --chain-name "casper-net-1" \
        --gas-price "10" \
        --payment-amount "10000000000000" \
        --ttl "1day" \
        --secret-key "$USER1_SECRET_KEY" \
        --session-hash "$CONTRACT_HASH" \
        --session-entry-point "store_string" \
        --session-arg "$(get_cl_arg_string 'name' "$DOCUMENT_CHECKSUM")" \
        --session-arg "$(get_cl_arg_string 'value' "$DOCUMENT_METADATA")" \
        > /dev/null 2>&1

    $PATH_TO_CLIENT sign-deploy \
        --input "$PATH_TO_DEPLOY" \
        --output "$PATH_TO_DEPLOY" \
        --secret-key "$USER2_SECRET_KEY" \
        > /dev/null 2>&1
}

_main
