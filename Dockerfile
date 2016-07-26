FROM sasah/alpine-glibc:latest

ENV JAVA_HOME="/usr/java" \
    JAVA_OPTS="-Dfile.encoding=UTF-8 -Duser.timezone=Europe/Moscow"

RUN JAVA_UPDATE="102" && \
    JAVA_BUILD="14" && \

    apk --no-cache add --virtual .build-deps \
        wget \
        ca-certificates \
        unzip && \

    cd /tmp && \
    wget -nv --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
        http://download.oracle.com/otn-pub/java/jdk/8u${JAVA_UPDATE}-b${JAVA_BUILD}/jdk-8u${JAVA_UPDATE}-linux-x64.tar.gz \
        http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip && \

    tar -xzf jdk-8u${JAVA_UPDATE}-linux-x64.tar.gz && \
    unzip jce_policy-8.zip && \
    mkdir -p /usr/java && \
    cd /tmp/jdk1.8.0_${JAVA_UPDATE} && \
    mv -v * /usr/java && \
    mv -v /tmp/UnlimitedJCEPolicyJDK8/*.jar /usr/java/jre/lib/security && \

    apk del .build-deps && \

    rm -rvf /usr/java/jre/lib/ext/nashorn.jar \
            /usr/java/jre/lib/jfr.jar \
            /usr/java/jre/lib/jfr \
            /usr/java/jre/lib/oblique-fonts \
            /usr/java/lib/missioncontrol \
            /usr/java/lib/visualvm \
            /usr/java/lib/*javafx* \
            /usr/java/jre/lib/plugin.jar \
            /usr/java/jre/lib/ext/jfxrt.jar \
            /usr/java/jre/lib/javaws.jar \
            /usr/java/jre/lib/desktop \
            /usr/java/jre/plugin \
            /usr/java/jre/lib/deploy* \
            /usr/java/jre/lib/*javafx* \
            /usr/java/jre/lib/*jfx* \
            /usr/java/jre/lib/amd64/libdecora_sse.so \
            /usr/java/jre/lib/amd64/libprism_*.so \
            /usr/java/jre/lib/amd64/libfxplugins.so \
            /usr/java/jre/lib/amd64/libglass.so \
            /usr/java/jre/lib/amd64/libgstreamer-lite.so \
            /usr/java/jre/lib/amd64/libjavafx*.so \
            /usr/java/jre/lib/amd64/libjfx*.so \

            /usr/java/db \
            /usr/java/include \
            /usr/java/man \

            /usr/java/*.zip \

            /usr/java/COPYRIGHT \
            /usr/java/LICENSE \
            /usr/java/README.html \
            /usr/java/THIRDPARTYLICENSEREADME.txt \
            /usr/java/THIRDPARTYLICENSEREADME-JAVAFX.txt \

            /usr/java/jre/COPYRIGHT \
            /usr/java/jre/LICENSE \
            /usr/java/jre/README \
            /usr/java/jre/Welcome.html \
            /usr/java/jre/THIRDPARTYLICENSEREADME.txt \
            /usr/java/jre/THIRDPARTYLICENSEREADME-JAVAFX.txt && \

    find -L /usr/java/bin -type f -not -name 'java' -print0 | xargs -0 rm -v -- && \
    find -L /usr/java/jre/bin -type f -not -name 'java' -print0 | xargs -0 rm -v -- && \

    ln -sv /usr/java/bin/* /usr/bin/ && \

    rm -rvf /tmp/*
