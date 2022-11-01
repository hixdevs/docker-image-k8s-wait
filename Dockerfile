FROM alpine:latest
ENV GROUP_ID=10001 \
GROUP_NAME=k8sw8 \
USER_ID=10001 \
USER_NAME=k8sw8
RUN addgroup -g $GROUP_ID -S $GROUP_NAME \
&& adduser -S -u $USER_ID -G $GROUP_NAME -D -H $USER_NAME \
&& apk add --no-cache \
bash \
curl
COPY k8sw8.sh ./
USER $USER_NAME:$GROUP_NAME
CMD [ "bash", "k8sw8.sh" ]
