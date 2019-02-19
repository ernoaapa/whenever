FROM alpine

RUN apk add inotify-tools
COPY whenever.sh .

ENTRYPOINT [ "./whenever.sh" ]
