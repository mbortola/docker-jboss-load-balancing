# Steps taken to create this image
# docker build --rm -t jboss/jboss_eap:6.3.0  .
# docker run -p 9990:9990 -p 9999:9999 -p 8080:8080 -it jboss/jboss_eap:6.3.0
#
# Get required ZIP file from: https://access.redhat.com/jbossnetwork/restricted/softwareDownload.html?softwareId=32483&product=appplatform
#
#
FROM jboss/base:latest

# User root user to install software
USER root

RUN yum -y install wget zip unzip curl && cd /opt && wget --no-cookies --no-check-certificate \
  --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u77-b03/jdk-8u77-linux-x64.tar.gz" && \
  tar xzf jdk-8u77-linux-x64.tar.gz && rm *.gz && \
  mkdir /usr/java && mv  /opt/jdk1.8.0* /usr/java/jdk1.8.0 && \
  mkdir /home/jboss/ $INSTALLDIR $INSTALLDIR/distribution $INSTALLDIR/resources

# Set the JAVA_HOME variable to make it clear where Java is located
ENV JAVA_HOME /usr/java/jdk1.8.0
ENV INSTALLDIR /home/jboss/EAP-6.4.0
ENV EAP_HOME $INSTALLDIR/jboss-eap-6.4

ADD distribution $INSTALLDIR/distribution
ADD distribution-patches $INSTALLDIR/distribution-patches
ADD startup.sh $INSTALLDIR

RUN unzip $INSTALLDIR/distribution/jboss-eap-6.4.0.zip  -d $INSTALLDIR && \
    $INSTALLDIR/jboss-eap-6.4/bin/jboss-cli.sh "patch apply $INSTALLDIR/distribution-patches/jboss-eap-6.4.6-patch.zip" && \
    chmod +x $INSTALLDIR/startup.sh

# Add default admin user
RUN ${EAP_HOME}/bin/add-user.sh admin admin123! --silent

# Enable binding to all network interfaces and debugging inside the EAP
RUN echo "JAVA_OPTS=\"\$JAVA_OPTS -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0\"" >> ${EAP_HOME}/bin/standalone.conf
VOLUME ${EAP_HOME}/standalone/logs

EXPOSE 9990 9999 8080 8787

#USER jboss

ENTRYPOINT "$INSTALLDIR/startup.sh"
#CMD []
