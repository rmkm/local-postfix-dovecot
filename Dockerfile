FROM centos:centos7

ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]

RUN yum -y update && yum -y install postfix dovecot rsyslog vim
RUN systemctl enable postfix
RUN systemctl enable dovecot

RUN mv /etc/postfix/main.cf /etc/postfix/main.cf.bkup
RUN mv /etc/dovecot/conf.d/10-mail.conf /etc/dovecot/conf.d/10-mail.conf.bkup
RUN mv /etc/dovecot/conf.d/10-auth.conf /etc/dovecot/conf.d/10-auth.conf.bkup
RUN mv /etc/dovecot/conf.d/10-ssl.conf /etc/dovecot/conf.d/10-ssl.conf.bkup

COPY main.cf /etc/postfix/
COPY 10-mail.conf /etc/dovecot/conf.d/
COPY 10-auth.conf /etc/dovecot/conf.d/
COPY 10-ssl.conf /etc/dovecot/conf.d/

RUN chmod 777 /var/spool/mail
