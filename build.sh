#!/usr/bin/env sh

# Font helpers.
VERSION="6.0.0-preview.1"
URL="https://github.com/be5invis/Iosevka/archive/refs/tags/v$VERSION.tar.gz"
DIR="Iosevka-$VERSION"

# Color helpers.
GRN="\033[0;32m"
CLR="\033[0m"

log() {
    printf "$GRN%s$CLR %s\n" "$(date +%F\ %H:%M:%S)" "$@"
}


download() {
    if [ -d "$DIR" ]; then
        log "Source code is already available."
    else
        log "Downloading and extracting source code."
        curl -L $URL | tar xvz
    fi
}

build() {
    cd $DIR

    log "Installing NPM dependencies."
    npm install

    log "Building default font."
    npm run build -- contents::iosevka
}

main() {
    download
    build
}

main
