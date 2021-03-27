FROM centos

ENV UPDATE_VERSION=8u121
ENV JAVA_VERSION=1.8.0_121
ENV BUILD=b13

RUN	yum -y update && \
	yum -y install wget && \
	wget --no-cookies --no-check-certificate --header "Cookie:oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.rpm" && \
	rpm -i jdk-${UPDATE_VERSION}-linux-x64.rpm && \
	alternatives --install /usr/bin/java java /usr/java/jdk${JAVA_VERSION}/bin/java 1 && \
	alternatives --set java /usr/java/jdk${JAVA_VERSION}/bin/java && \
	export JAVA_HOME=/usr/java/jdk${JAVA_VERSION}/ && \
	echo "export JAVA_HOME=/usr/java/jdk${JAVA_VERSION}/" | tee /etc/environment && \
	source /etc/environment && \
	rm jdk-${UPDATE_VERSION}-linux-x64.rpm

ENV JAVA_HOME=/usr/java/jdk${JAVA_VERSION}/

COPY ./helloworld.war /helloworld.war
 
CMD ["java", "-jar", "/helloworld.war"]
