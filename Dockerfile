FROM adoptopenjdk/openjdk8-openj9:alpine-slim

RUN mkdir -p /waterfall
ADD ./config /waterfall/

COPY ./build.sh /build.sh
RUN sh /build.sh

COPY ./run.sh /run.sh

ENV JAVA_MEMORY=512M
ENV JAVA_ARGS=

CMD ["sh", "/run.sh"]
