FROM centos:8

RUN yum update -y && \
    yum install -y wget && \
    wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo && \
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key && yum upgrade && \
    yum install -y jenkins java-1.8.0-openjdk-devel && \
    yum install -y initscripts && \
    export JENKINS_AJP_PORT="-1" 
ENTRYPOINT /etc/rc.d/init.d/jenkins restart