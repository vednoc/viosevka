#!/usr/bin/env sh

# Font helpers.
VERSION="6.0.0-preview.1"
URL="https://github.com/be5invis/Iosevka/archive/refs/tags/v$VERSION.tar.gz"
DIR="src"

# Color helpers.
RED="\033[0;31m"
GRN="\033[0;32m"
CLR="\033[0m"

log() {
    printf "$GRN%s$CLR %s\n" "$(date +%F\ %H:%M:%S)" "$@"
}

lor() {
    printf "$RED%s$CLR %s\n" "$(date +%F\ %H:%M:%S)" "$@"
}

cmd() {
    if ! command -v "$1" >/dev/null; then
        lor "Missing '$1' command. Build stopped."
        exit 1
    fi
}

err() {
    out="$?"
    if [ ! "$out" = 0 ]; then
        lor "Ran into an error. Build stopped."
        exit 1
    fi
}

download() {
    if [ -d "$DIR" ]; then
        log "Source code is already available."
    else
        log "Downloading and extracting source code."
        curl -L $URL | tar xz
        mv Iosevka-* $DIR
    fi
}

build() {
    cp viosevka.toml $DIR/private-build-plans.toml

    cd $DIR
    cmd npm

    log "Installing NPM dependencies."
    npm install

    log "Building default font."
    npm run build -- ttf::viosevka

    cd ..
}

link() {
    if [ ! -L "font" ]; then
        ln -s "$DIR/dist/viosevka" font
    fi

    log "Font built successfully."
}

main() {
    download || err
    build || err
    link || err
}

main
