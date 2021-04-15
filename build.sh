#!/usr/bin/env sh

# Color helpers.
GRN="\033[0;32m"
CLR="\033[0m"

log() {
    printf "$GRN%s$CLR %s\n" "$(date +%F\ %H:%M:%S)" "$@"
}

main() {
    log "Hello, World!"
}

main
