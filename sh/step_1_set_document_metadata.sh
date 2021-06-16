function _set_document_metadata()
{
    if [ -f "$_PATH_TO_DEMO/outputs/document-metadata" ]; then
        rm "$_PATH_TO_DEMO/outputs/document-metadata"
    fi

    _CHECKSUM=$(cat "$_PATH_TO_DEMO/outputs/document-checksum")

    cat >> "$_PATH_TO_DEMO/outputs/document-metadata" <<- EOM
Timestamp         : $(date +%Y-%m-%dT%H:%M:%S.%6N)
URL               : https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3398004
Description       : Major Translation Methods Used in Legal Documents: Translation of a Marriage Contract from Arabic into English
Checksum          : $_CHECKSUM
EOM

    less "$_PATH_TO_DEMO/outputs/document-metadata"
}

_set_document_metadata
