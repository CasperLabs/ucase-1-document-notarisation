
function _main()
{
    local NODE_ADDRESS=$(get_node_address_rpc node="1")
    local PATH_TO_CLIENT=$(get_path_to_client)
    local STATE_ROOT_HASH=$(get_state_root_hash)

    local DOCUMENT_CHECKSUM=$(cat "$_PATH_TO_DEMO/outputs/document-checksum")
    local CONTRACT_HASH=$(cat "$_PATH_TO_DEMO/outputs/contract-hash")

    log "querying chain @ state root hash -> $STATE_ROOT_HASH"  

    local DOCUMENT_METADATA_UREF=$(
        $PATH_TO_CLIENT query-state \
            -k "$CONTRACT_HASH" \
            -n "$NODE_ADDRESS" \
            -s "$STATE_ROOT_HASH" \
            | jq '.result.stored_value.Contract.named_keys[] | select(.name == "'"$DOCUMENT_CHECKSUM"'") | .key' \
            | sed -e 's/^"//' -e 's/"$//'
    )

    local DOCUMENT_METADATA=$(
        $PATH_TO_CLIENT query-state \
            -k $DOCUMENT_METADATA_UREF \
            -n $NODE_ADDRESS \
            -s $STATE_ROOT_HASH \
            | jq '.result.stored_value.CLValue.parsed'
    )

    echo "---------------------------------------------------------------------------------"
    echo "Smart Contract ID : $CONTRACT_HASH"
    echo "---------------------------------------------------------------------------------"
    echo -e "$DOCUMENT_METADATA" | sed -e 's/^"//' -e 's/"$//'
    echo "---------------------------------------------------------------------------------"
}

_main
