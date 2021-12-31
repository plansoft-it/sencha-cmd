FROM registry.access.redhat.com/ubi8/ubi-minimal

LABEL org.opencontainers.image.authors="marco.sarti@plansoft.it"

RUN microdnf install which tar curl ruby unzip java-1.8.0-openjdk \
    && microdnf update \
    && microdnf clean all \
    && mkdir /builds \
    && mkdir /opt/sencha

RUN curl -o /root/cmd.sh.zip http://cdn.sencha.com/cmd/7.0.0.40/no-jre/SenchaCmd-7.0.0.40-linux-amd64.sh.zip \
    && unzip -p /root/cmd.sh.zip > /root/cmd-install.sh \
    && chmod +x /root/cmd-install.sh \
    && /root/cmd-install.sh -q \
    && rm /root/cmd*

ENV PATH /root/bin/Sencha/Cmd/7.0.0.40/:$PATH

WORKDIR /builds

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]
