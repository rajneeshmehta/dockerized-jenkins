FROM centos:8

RUN yum update -y && \
    yum install -y wget && \
    wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo && \
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key && yum upgrade && \
    yum install -y jenkins java-11-openjdk.x86_64 && \
    echo -e "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER jenkins
ENV USER jenkins
CMD java -jar /usr/lib/jenkins/jenkins.war