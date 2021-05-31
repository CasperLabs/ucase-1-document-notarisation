function _main()
{
    local USER3_SECRET_KEY=$(get_path_to_secret_key "$NCTL_ACCOUNT_TYPE_USER" "3")
    local PATH_TO_DEPLOY_IN="$_PATH_TO_DEMO/assets/deploy-2.json"
    local PATH_TO_DEPLOY_OUT="$_PATH_TO_DEMO/assets/deploy-3.json"

    $_PATH_TO_CLIENT sign-deploy \
        --input "$PATH_TO_DEPLOY_IN" \
        --output "$PATH_TO_DEPLOY_OUT" \
        --secret-key "$USER3_SECRET_KEY" \
        > /dev/null 2>&1
    
    cat $PATH_TO_DEPLOY_OUT | jq '.approvals'
}

_main
