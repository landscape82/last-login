#!/bin/bash
#Check whether root user is running the script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
rpm_present="`rpm -qa | grep mailx`"
  if [ "$rpm_present" == "1" ]; then
       	echo -e "\n MAilx already Installed  .. "
  else
       	sudo yum install mailx
  fi
sendml_present="`rpm -qa | grep sendmail`"
  if [ "$sendml_present" == "1" ]; then
       	echo -e "\n Sendmail already Installed  .. "
  else
       	sudo yum install sendmail
  fi
sudo /etc/init.d/sendmail restart
read -p "whats the hostname? : " host
cd /usr/local/sbin/
echo " #!/bin/bash
RECIPIENT="devops@domainmoofwd.com";
PREFIX="LOGIN ALERT OF $host!";
REMOTEIP=$(/bin/echo $SSH_CLIENT | /usr/bin/awk '{ print $1 }');
TIME=$(/bin/date +'%r, %D');
HOST=$(/bin/hostname -f);

if [[ "$REMOTEIP" == "" ]]; then
   REMOTEIP='localhost';
fi

/bin/cat <<LOGGEDIN |sudo /bin/mail -s "$PREFIX $USER@$HOST $TIME" $RECIPIENT
Remote user $USER just logged in to $HOST at $TIME from $REMOTEIP
LOGGEDIN

exit $? " >> lastlogin

chmod 755 lastlogin

echo "#last login configuration by Devops" >> /etc/profile
echo  "/usr/local/sbin/lastlogin >/dev/null 2>&1 && disown -a" >> /etc/profile
echo " LastLogin script has been added to the server Thanx for Using"
