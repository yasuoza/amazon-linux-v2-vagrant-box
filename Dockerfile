FROM amazonlinux:2

ARG USER="ec2-user"

RUN yum -y update && yum -y install sudo which openssh-server openssh-clients git

RUN adduser $USER && mkdir -p /home/$USER/.ssh && chown $USER:$USER /home/$USER/.ssh && chmod 0700 /home/$USER/.ssh
ADD ./ssh/authorized_keys.pub /home/$USER/.ssh/authorized_keys
RUN chown $USER:$USER /home/$USER/.ssh/authorized_keys && chmod 0600 /home/$USER/.ssh/authorized_keys

RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# https://qiita.com/mats116/items/59615a169a45884c2548
RUN echo "NETWORKING=yes" > /etc/sysconfig/network

RUN /etc/init.d/sshd start

CMD ["/sbin/init"]
