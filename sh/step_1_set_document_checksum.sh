function _main()
{
    if [ -f "$_PATH_TO_DEMO/outputs/document-checksum" ]; then
        rm "$_PATH_TO_DEMO/outputs/document-checksum"
    fi

    _CHECKSUM=$(sha256sum "$_PATH_TO_DEMO/assets/document.pdf")
    IFS=' '
    read -ra _CHECKSUM <<< "$_CHECKSUM"

    cat >> "$_PATH_TO_DEMO/outputs/document-checksum" <<- EOM
${_CHECKSUM[0]}
EOM

    echo "-----------------------------------------------------------------------------------------------------------"
    echo "Document Checksum = ${_CHECKSUM[0]}"
    echo "-----------------------------------------------------------------------------------------------------------"
}

_main