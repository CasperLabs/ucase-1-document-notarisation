_ACCOUNT_KEY=$(get_account_key "$NCTL_ACCOUNT_TYPE_USER" "1")
_ACCOUNT_HASH=$(get_account_hash "$_ACCOUNT_KEY")
_STATE_ROOT_HASH=$(get_state_root_hash)

echo "-----------------------------------------------------------------------------------------------------------"
echo "Account B = Legal Clerk"
echo "a/c key  : $_ACCOUNT_KEY"
echo "a/c hash : $_ACCOUNT_HASH"
echo "-----------------------------------------------------------------------------------------------------------"

source "$NCTL"/sh/views/view_chain_account.sh \
    root-hash="$_STATE_ROOT_HASH" \
    account-key="$_ACCOUNT_KEY" \
    | jq '.stored_value.Account'

echo "-----------------------------------------------------------------------------------------------------------"
