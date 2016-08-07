# pure-ftpd container based on alpine
FROM alpine:edge
MAINTAINER nasacct
EXPOSE 21
COPY repositories /etc/apk
RUN apk update && apk upgrade && apk add pure-ftpd
RUN adduser -g pure-ftpd -h /var/empty -s /etc -D pure-ftpd && \
    adduser -g ftpgroup -h /dev/null -s /etc -D ftpuser && \
    mkdir /var/ftproot && \
    mkdir /etc/pureftpd.d
VOLUME [ "/var/ftproot", "/etc/pureftpd.d" ]
CMD [ "/usr/sbin/pure-ftpd", "-EH", "-l", "puredb:/etc/pureftpd.d/pureftpd.pdb", "-p", "40000:40009" ]
