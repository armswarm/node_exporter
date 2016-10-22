FROM armhf/alpine:latest
MAINTAINER armswarm

# metadata params
ARG PROJECT_NAME
ARG BUILD_DATE
ARG VCS_URL
ARG VCS_REF

# metadata
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name=$PROJECT_NAME \
      org.label-schema.url=$VCS_URL \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vendor="armswarm" \
      org.label-schema.version="latest"

ARG NODE_EXPORTER_VERSION
ENV NODE_EXPORTER_VERSION=${NODE_EXPORTER_VERSION}

RUN \
 apk add --no-cache --virtual=build-dependencies \
	curl && \

# install syncthing
 curl -so \
 /tmp/node_exporter.tar.gz -L \
    "https://github.com/prometheus/node_exporter/releases/download/${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-armv7.tar.gz" && \
 tar xfz \
    /tmp/node_exporter.tar.gz -C /tmp && \

 mv /tmp/node_exporter-${NODE_EXPORTER_VERSION}.linux-armv7/node_exporter /bin/node_exporter && \

# clean up
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/tmp/*

EXPOSE 9100

ENTRYPOINT ["/bin/node_exporter"]
