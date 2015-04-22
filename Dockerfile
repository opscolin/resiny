## build jdk1.7.60 with centos7
FROM centos:7
MAINTAINER Colin <1209755822@qq.com>
# set language and system time 
RUN export LANG=en_US.UTF-8
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# install related tool
RUN yum install -y wget tar gcc make 
# download source package 
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u60-b19/jdk-7u60-linux-x64.rpm" && wget http://www.caucho.com/download/resin-4.0.40.tar.gz
# install 
RUN rpm -ivh jdk-7u60-linux-x64.rpm
RUN tar -zxvf resin-4.0.40.tar.gz && cd resin-4.0.40 && ./configure --prefix=/usr/local/resin   && make && make install
# clean unuseful package 
RUN rm -rf jdk-7u60-linux-x64.rpm && rm -rf resin-4.0.40* && yum clean all
VOLUME ["/www"]
EXPOSE 8079 8080 8081 9093
# set for resin 
ADD resin-new-hessian.jar /usr/local/resin/lib/
ADD javaee-16.jar /usr/local/resin/lib/
ADD mysql-connector-java-5.1.6-bin.jar /usr/local/resin/lib/
ADD resin.sh /usr/local/resin/bin/resin.sh
ADD start_kk.sh /usr/bin/start
ADD hosts /tmp/hosts
ENTRYPOINT ["/usr/bin/start"]
CMD ["demo"]
