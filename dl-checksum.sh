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
    local platform="${os}-${arch}"
    local url="${MIRROR}/v${ver}${file}/spacetime.${platform}.${archive_type}"
    local lfile="${DIR}/spacetime.${ver}.${platform}.${archive_type}"

    if [ ! -e $lfile ];
    then
        curl -sSLf -o $lfile $url
    fi
    # https://github.com/clockworklabs/SpacetimeDB/releases/download/v0.7.1-beta-hotfix1/spacetime.linux-amd64.tar.gz
    # https://github.com/clockworklabs/SpacetimeDB/releases/download/v0.6.1-beta/spacetime.darwin-amd64.tar.gz
    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform $(sha256sum $lfile | awk '{print $1}')
}

dlver () {
    local ver=$1
    printf "  '%s':\n" $ver
    dl $ver darwin amd64
    dl $ver darwin arm64
    dl $ver linux amd64
    dl $ver linux arm64
}

dlver ${1:-"0.7.1-beta-hotfix1"}
