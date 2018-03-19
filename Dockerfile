FROM quay.io/armswarm/alpine:3.7

ARG NODE_EXPORTER_VERSION
ENV NODE_EXPORTER_VERSION=${NODE_EXPORTER_VERSION}

RUN \
 apk add --no-cache --virtual=.fetch-dependencies \
	curl && \
 curl -so \
 /tmp/node_exporter.tar.gz -L \
    "https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-armv7.tar.gz" && \
 tar xfz \
    /tmp/node_exporter.tar.gz -C /tmp && \
 mv /tmp/node_exporter-${NODE_EXPORTER_VERSION}.linux-armv7/node_exporter /bin/node_exporter && \
# clean up
 apk del --purge \
	.fetch-dependencies && \
 rm -rf \
	/tmp/*

EXPOSE 9100
USER nobody

ENTRYPOINT ["/bin/node_exporter"]
