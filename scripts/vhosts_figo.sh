#! /bin/bash 
# 
# =======================
# Siteup Script 0.1
# Written by Command Line Idiot
# http://commandlineidiot.com
# You may use, modify, and redistribute this script freely
# Released: August 2007
# =======================

# =======================
#	set functions
# =======================
#	make_index is the function to create a basic index.html file
# 	within the documents directory of the new domain. The variable
# 	for domain name is passed into the file at $dname. You can alter
#	any of the code between the terms _EOF_ and it will be reflected
#	in the index.html file.

function make_index
{
cat <<- _EOF_
	<html>
	<head><title>$dname</title></head>
	<body>welcome to $dname</body> 
	</html>
_EOF_
} 

#	make_vhost is the function to create a config file that
#	Apache2 can interpret. The variable for the domain name is passed
#	into the file at $dname, and the system-wide variable for username
#	is passed into the file at $USER. You may wish to replace the
#	ServerAdmin email address with your own email address. You may alter
#	any of the code between the terms _EOF_ to build your own preferred 
#	standard config file.  

function make_vhost
{
cat <<- _EOF_
	<VirtualHost *>
	        ServerAdmin $USER@localhost
	        ServerName $dname
	        ServerAlias *.$dname

	        DirectoryIndex index.html index.htm index.php
	        DocumentRoot /webserver/html_projects/$dname/

	        ScriptAlias /cgi-bin/ /webserver/html_projects/$dname/cgi-bin/
	        <Location /cgi-bin>
	                Options +ExecCGI
	        </Location>

	        <Directory /webserver/html_projects/$dname/>
	                Options Indexes FollowSymLinks MultiViews
	                AllowOverride All
	                Order allow,deny
	                Allow from all
	        </Directory>

	        ErrorLog /webserver/html_projects/logs/$dname/error.log
	        CustomLog /webserver/html_projects/logs/$dname/access.log combined
	</VirtualHost>
_EOF_
}

# =======================
#	     header
# =======================
clear  
echo "***      Site Setup      ***"
 
# =======================
# set domain name variable
# =======================
echo -n "==> Enter new domain name (domain.com): "
read dname
echo "Setting up files for $dname"

# =======================
# create needed directories
# =======================
mkdir -vp /webserver/html_projects/$dname
mkdir -vp /webserver/html_projects/$dname/cgi-bin
mkdir -vp /webserver/html_projects/logs/$dname
touch /webserver/html_projects/logs/$dname/access.log 
echo "created /webserver/html_projects/logs/$dname/access.log"
touch /webserver/html_projects/logs/$dname/error.log 
echo "created /webserver/html_projects/logs/$dname/error.log"

# =======================
# build index.html file
# =======================
make_index > /webserver/html_projects/$dname/index.html
echo "created /webserver/html_projects/$dname/index.html"

# =======================
# build vhost config file
# =======================
make_vhost > /etc/apache2/sites-available/$dname
echo "created /etc/apache2/sites-available/$dname"

# =======================
#    exit
# =======================

echo "***      Finished setting up files for $dname. Goodbye!"
exit
