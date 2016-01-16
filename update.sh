#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

version="$1"
md5="$2"
check_result=0
check_tar()
{
    if [ -f kubernetes.tar.gz ]; then
        kmd5=`md5sum kubernetes.tar.gz | cut -f1 -d" " `
        echo $kmd5 $md5
        if [ "$md5" == "$kmd5" ]; then
            check_result=1
        fi
    fi
}

download_hyperkube()
{
    mkdir -p kube-binaries

    check_tar
    if [ $check_result -eq 0 ]; then
        curl -L -v "https://github.com/kubernetes/kubernetes/releases/download/$version/kubernetes.tar.gz" -o kubernetes.tar.gz

    else
        echo "Skip download"
    fi
    tar xvf kubernetes.tar.gz
    tar xvf kubernetes/server/kubernetes-server-linux-amd64.tar.gz -C kube-binaries
    cp kube-binaries/kubernetes/server/bin/hyperkube build
    rm -rf kubernetes
    rm -rf kube-binaries
}

download_hyperkube
git add ./build && git commit -m "Hyperkube $version" && git tag $version -f
