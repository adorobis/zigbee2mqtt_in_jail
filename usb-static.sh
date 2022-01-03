#!/bin/bash

function get_tty () {
    local vendor="${1}"
    local product="${2}"
    # return the tty{} value, eg; U2
    sysctl dev.umodem | grep "vendor=${vendor} product=${product}" | sed -r 's/.*ttyname=([^\s]+) .*/\1/'
}

function create_symlink () {
    local source="${1}"
    # failsafe
    if [ "${source}" == 'tty' ]; then return; fi
    local target="/mnt/Dane/iocage/jails/${3}/root/dev/${2}"
    if [ -e "${target}" ]; then rm -f "${target}"; fi
    ln -s "${source}" "${target}"
}

# zigbee is a Conbee 2
create_symlink "cua$(get_tty '0x1cf1' '0x0030')" "cuaUzigbee" "zigbee"
# zwave is a Z-Stick Gen 5
create_symlink "cua$(get_tty '0x0658' '0x0200')" "cuaUzwave" "zwave"
