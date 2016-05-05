
FROM jboss/base:latest

# User root user to install software
USER root

# Set the JAVA_HOME variable to make it clear where Java is located
ENV JAVA_HOME /usr/java/jdk1.8.0
ENV INSTALLDIR /home/jboss/EAP-6.4.0
ENV EAP_HOME $INSTALLDIR/jboss-eap-6.4

RUN yum -y install wget zip unzip curl net-tools && cd /opt && wget --no-cookies --no-check-certificate \
  --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u77-b03/jdk-8u77-linux-x64.tar.gz" && \
  tar xzf jdk-8u77-linux-x64.tar.gz && rm *.gz && \
  mkdir /usr/java && mv  /opt/jdk1.8.0* /usr/java/jdk1.8.0 && \
  mkdir /home/jboss/ $INSTALLDIR $INSTALLDIR/distribution $INSTALLDIR/resources

ADD distribution $INSTALLDIR/distribution
ADD distribution-patches $INSTALLDIR/distribution-patches
ADD startup.sh /opt
ADD base-startup.sh /opt
ADD configuration /opt

RUN unzip $INSTALLDIR/distribution/jboss-eap-6.4.0.zip  -d $INSTALLDIR && \
    $INSTALLDIR/jboss-eap-6.4/bin/jboss-cli.sh "patch apply $INSTALLDIR/distribution-patches/jboss-eap-6.4.6-patch.zip" && \
    chmod +x /opt/*startup.sh

# Add default admin user
RUN ${EAP_HOME}/bin/add-user.sh admin admin123! --silent

# Enable binding to all network interfaces and debugging inside the EAP
RUN echo "JAVA_OPTS=\"\$JAVA_OPTS -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0\"" >> ${EAP_HOME}/bin/standalone.conf
VOLUME ${EAP_HOME}/standalone/logs

EXPOSE 9990 9999 8080 8787

#USER jboss

#ENTRYPOINT "/opt/base-startup.sh"
#CMD []
