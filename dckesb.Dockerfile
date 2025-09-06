FROM ubuntu:22.04

RUN apt update && apt upgrade \
  && apt install -y bash && apt install -y curl \
  && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
  && localedef -i ru_RU -c -f UTF-8 -A /usr/share/locale/locale.alias ru_RU.UTF-8

ENV LC_ALL=ru_RU.UTF-8
ENV LANG=ru_RU.UTF-8
ENV LANGUAGE=ru_RU.UTF-8

COPY ./esb /tmp/esb
RUN /tmp/esb/1ce-installer-cli install all --disable-service-creation --ignore-hardware-checks
RUN rm -rf /tmp/esb

RUN ln -s $(find /opt/1C/1CE/components -name 'azul-jfk*') /opt/1C/1CE/components/azul-jdk \
  && ln -s $(find /opt/1C/1CE/components -name '1c-enterprise-esb*') /opt/1C/1CE/components/1c-enterprise-esb
ENV JAVA_HOME=/opt/1C/1CE/components/azul-jdk
ENV PATH="/opt//1C/1CE/components/1c-enterprise-esb/bin:$PATH"


USER usr1ce:grp1ce
WORKDIR /opt/1C/1CE/components/1c-enterprise-esb

EXPOSE 9090/tcp
EXPOSE 8080/tcp
EXPOSE 6698/tcp

ENTRYPOINT [ "/opt/1C/1CE/components/1c-enterprise-esb/bin/esb", "start", "--procname", "1c-enterprise", "--instance", "/var/opt/1C/1CE/instances/1c-enterprise-esb-with-ide"]

HEALTHCHECK --interval=5m --timeout=3s --start-interval=600s \
  CMD curl --fail http://localhost:9090/maintenance/server/v1/heartbeat || exit 1
  