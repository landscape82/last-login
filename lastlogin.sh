#!/bin/bash
#Author: Vinod.N K
#Distro : Linux -Centos, Rhel, and any fedora
#Check whether root user is running the script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
 if rpm -q mailx &> /dev/null; then
        echo "MAilx is installed..."
    else
        echo "Installing mailx..." && sudo yum install mailx -y
    fi
if rpm -q sendmail &> /dev/null; then
        echo "Sendmail is installed..."
  else
       echo "Installing sendmail"... && sudo yum install sendmail -y
  fi
if rpm -q newt &> /dev/null; then
        echo "Newt is installed..."
  else
       echo "Installing Newt"... && sudo yum install newt -y
  fi
echo "restarting Sendmail..."
sudo /etc/init.d/sendmail restart
host=$(whiptail --title " LASTLOGIN SCRIPT " --inputbox "Please Enter hostname in CAPS? : " 10 60 HOSTNAME 3>&1 1>&2 2>&3)
cd /usr/local/sbin/
echo '#!/bin/bash
RECIPIENT="user@domain.com";
PREFIX="LOGIN ALERT FROM '$host!'";
REMOTEIP=$(/bin/echo $SSH_CLIENT | /usr/bin/awk "{ print $1 }");
TIME=$(/bin/date +"%r, %D");
HOST=$(/bin/hostname -f);
 
if [[ "$REMOTEIP" == "" ]]; then
   REMOTEIP="localhost";
fi
 
/bin/cat <<LOGGEDIN |sudo /bin/mail -s "$PREFIX $USER@$HOST $TIME" $RECIPIENT
Remote user $USER just logged in to $HOST at $TIME from $REMOTEIP
LOGGEDIN
 
exit $?
' | sudo tee /usr/local/sbin/lastlogin

chmod 755 /usr/local/sbin/lastlogin

echo "#last login configuration by Devops" >> /etc/profile
echo  "/usr/local/sbin/lastlogin >/dev/null 2>&1 && disown -a" >> /etc/profile
echo "Thanx for Using..."
