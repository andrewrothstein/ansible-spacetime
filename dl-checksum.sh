#!/usr/bin/env sh
set -e
DIR=~/Downloads
MIRROR=https://github.com/clockworklabs/SpacetimeDB/releases/download

dl()
{
    local ver=$1
    local os=$2
    local arch=$3
    local archive_type=${4:-tar.gz}
    local platform="${arch}-${os}"
    local url="${MIRROR}/v${ver}${file}/spacetime-${platform}.${archive_type}"
    local lfile="${DIR}/spacetime-${ver}.${platform}.${archive_type}"

    if [ ! -e $lfile ];
    then
        curl -sSLf -o $lfile $url
    fi

    # https://github.com/clockworklabs/SpacetimeDB/releases/download/v1.0.0/spacetime-aarch64-apple-darwin.tar.gz
    # https://github.com/clockworklabs/SpacetimeDB/releases/download/v1.0.0/spacetime-x86_64-apple-darwin.tar.gz
    # https://github.com/clockworklabs/SpacetimeDB/releases/download/v1.0.0/spacetime-aarch64-unknown-linux-gnu.tar.gz
    # https://github.com/clockworklabs/SpacetimeDB/releases/download/v1.0.0/spacetime-x86_64-unknown-linux-gnu.tar.gz
    # https://github.com/clockworklabs/SpacetimeDB/releases/download/v1.0.0/spacetime-x86_64-pc-windows-msvc.zip

    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform $(sha256sum $lfile | awk '{print $1}')
}

dlver () {
    local ver=$1
    printf "  '%s':\n" $ver
    dl $ver apple-darwin aarch64
    dl $ver apple-darwin x86_64
    dl $ver unknown-linux-gnu aarch64
    dl $ver unknown-linux-gnu x86_64
}

dlver ${1:-1.0.0}
