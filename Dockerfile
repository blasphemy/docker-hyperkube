FROM alpine
ARG HYPERKUBE_VERSION=v1.2.5
ARG GLIBC_VERSION=2.23-r3
RUN apk --no-cache add ca-certificates wget iptables \
 && wget -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub \
 && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
 && apk add glibc-2.23-r3.apk --no-cache \
 && wget https://github.com/kubernetes/kubernetes/releases/download/${HYPERKUBE_VERSION}/kubernetes.tar.gz -O kubernetes.tar.gz \
 && mkdir kube-binaries \
 && tar xvf kubernetes.tar.gz \
 && tar xvf kubernetes/server/kubernetes-server-linux-amd64.tar.gz -C kube-binaries \
 && cp kube-binaries/kubernetes/server/bin/hyperkube /hyperkube \
 && cp kube-binaries/kubernetes/server/bin/kubectl /kubectl \
 && chmod u+x /kubectl \
 && chmod u+x /hyperkube \
 && rm -rf kubernetes \
 && rm -rf kube-binaries \
 && rm kubernetes.tar.gz \
 && rm glibc-2.23-r3.apk \
 && rm /etc/apk/keys/sgerrand.rsa.pub \
 && apk del wget alpine-keys apk-tools --no-cache
 CMD ["/kubectl"]
