FROM ubuntu:18.04

#updating the package repository
RUN apt-get update && \
    apt-get -qy full-upgrade && \
#Install ssh server
    apt-get install -qy openssh-server && \
    sed -i 's|session required pam_loginuid.so|session optional pam_loginuid.so|g' /etc/pam.d/sshd && \
    mkdir -p /var/run/sshd && \
#install JDK 8
   apt-get install -qy openjdk-8-jdk && \
#Install fortune 
   apt-get install -qy fortune && \
#Cleanup old packages
   apt-get -qy autoremove && \
#Create jenkins user
   adduser --quiet jenkins && \
#Set password for jenkins user
   echo "jenkins:jenkins" | chpasswd && \
#creating ssh directory
   mkdir -p /home/jenkins/.ssh 

#copying authorized keys to have the public key for ssh connection
#COPY ssh/authorized_keys /home/jenkins/.ssh/authorized_keys

#Assigning proper ownership

RUN chown -R jenkins:jenkins /home/jenkins/.ssh

#Standard ssh port

Expose 22

#Executing ssh server

CMD ["/usr/sbin/sshd", "-D"]
