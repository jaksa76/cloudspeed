FROM alpine

ARG RELEASE_VERSION
ENV RELEASE_VERSION ${RELEASE_VERSION}
LABEL release_version=${RELEASE_VERSION}
COPY ./target/smallface-$RELEASE_VERSION.jar smallface-$RELEASE_VERSION.jar
RUN apk update && \
    apk add openjdk8
EXPOSE 5000
ENTRYPOINT java -jar smallface-$RELEASE_VERSION.jar $RELEASE_VERSION
