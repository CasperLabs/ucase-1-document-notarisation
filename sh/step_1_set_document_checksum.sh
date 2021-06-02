
function _set_document_checksum()
{
    if [ -f "$_PATH_TO_DEMO/assets/document-checksum" ]; then
        rm "$_PATH_TO_DEMO/assets/document-checksum"
    fi

    _CHECKSUM=$(sha256sum "$_PATH_TO_DEMO/assets/document.pdf")
    IFS=' '
    read -ra _CHECKSUM <<< "$_CHECKSUM"

    cat >> "$_PATH_TO_DEMO/assets/document-checksum" <<- EOM
${_CHECKSUM[0]}
EOM

    echo "-----------------------------------------------------------------------------------------------------------"
    echo "Document Checksum = ${_CHECKSUM[0]}"
    echo "-----------------------------------------------------------------------------------------------------------"
}

_set_document_checksum