#!/bin/sh

set -e # Exit script immediately on first error.
set -x # Print commands and their arguments as they are executed.

# Update Debian package index.
apt-get update -y
apt-get upgrade -y

# Install required Debian packages.
# sudo apt-get install python python-dev automake python-mysqldb 
# mysql-server python-setuptools python-pip # python-virtualenv git 
# gunicorn nginx supervisor libmysqlclient-dev

apt-get install -y git-core
apt-get install -y python-pip build-essential python-dev
apt-get install -y python-virtualenv
apt-get install -y mercurial
apt-get install -y python-psycopg2

pip install --upgrade pip 
pip install --upgrade virtualenv 

# Clean up build products.
rm -rf "$tmp_dir"

