#! /bin/bash
# Instala o Apache e uma página inicial personalizada

apt-get update
apt-get install -y apache2
cat <<EOF > /var/www/index.html
<html><body><h1>Hello World</h1>
<p>This page was created from a simple start up script! by FigoTech</p>
</body></html>
EOF

# RHEL / CentOS / Fedora Linux restart command
# RESTART="/sbin/service httpd restart"
 
# uncomment if you are using Debian / Ubuntu Linux
RESTART="/etc/init.d/apache2 restart"
 
#path to pgrep command
PGREP="/usr/bin/pgrep"
 
# Httpd daemon name,
# Under RHEL/CentOS/Fedora it is httpd
# Under Debian 4.x it is apache2
HTTPD="httpd"
 
# find httpd pid
$PGREP ${HTTPD}
 
if [ $? -ne 0 ] # if apache not running
then
# restart apache
$RESTART
fi
