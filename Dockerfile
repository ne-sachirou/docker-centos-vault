FROM centos:6

COPY yum.repos.d /etc/yum.repos.d

RUN yum update -y \
 && rm -rf /var/cache/yum/* \
 && yum clean all
