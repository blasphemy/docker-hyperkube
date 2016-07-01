FROM alpine
COPY hyperkube /hyperkube
COPY kubectl /kubectl
RUN chmod u+x /hyperkube
RUN chmod u+x /kubectl
RUN apk --no-cache add ca-certificates wget iptables
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk
RUN apk add glibc-2.23-r3.apk
RUN apk del wget
RUN rm /etc/apk/keys/sgerrand.rsa.pub
RUN rm glibc-2.23-r3.apk
CMD ["/kubectl"]
