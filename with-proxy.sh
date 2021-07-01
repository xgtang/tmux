#!/bin/bash

function gen_ssh_proxy_files {
   cat <<"EOF" >$SSH_PROXY_FILE
Host *
   ProxyCommand nc -X 5 -x $SOCKS_PROXY %h %p
EOF
}

export SOCKS_PROXY="127.0.0.1:1086"
export http_proxy="http://127.0.0.1:1087"
export https_proxy="http://127.0.0.1:1087"
export SSH_PROXY_FILE="${HOME}/.ssh/config"
export SSH_PROXY_FILE_BAK="${HOME}/.ssh/config_bak"

mv -f $SSH_PROXY_FILE $SSH_PROXY_FILE_BAK

gen_ssh_proxy_files
function finish {
   mv -f $SSH_PROXY_FILE_BAK $SSH_PROXY_FILE
}
trap finish EXIT
$@
