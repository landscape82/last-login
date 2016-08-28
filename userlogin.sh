#!/bin/bash
#Script made logger details
#Author: Vinod.N K
#Usage: who logged in via ssh
#Distro : Linux -Centos, Rhel, and any fedora
#Check whether root user is running the script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
 if rpm -q mailx &> /dev/null; then
        echo "Mailx is installed..."
    else
        echo "Installing mailx..." && sudo yum install mailx -y
    fi
if rpm -q sendmail &> /dev/null; then
        echo "Sendmail is installed..."
  else
       echo "Installing sendmail"... && sudo yum install sendmail -y
  fi
echo "restarting Sendmail..."
sudo /etc/init.d/sendmail restart

read -p "whats is tha mail id? : " mailid

echo '#last login configuration by Devops
echo "Hello System Admin, This for your information. ALERT!!! - Check your Server. There seems to be a Root Shell Access on:' `date` `who` | mail -s "Alert: Root Access from `who | cut -d"(" -f2 | cut -d")" -f1`" $mailid"
' | sudo tee /root/.bashrc

echo " userlogin script has been added to the server Thanx for Using"
