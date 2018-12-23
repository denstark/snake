#!/bin/bash
yum -y -q install centos-release-scl-rh centos-release-scl
yum -y -q install epel-release
yum -y -q install vim
yum -y -q install rh-ruby23
yum -y -q install rh-ruby23-ruby-devel nodejs gcc make libxml2 libxml2-devel mariadb-devel zlib-devel libxslt-devel
yum -y -q install sqlite-devel
yum -y -q groupinstall 'Development Tools'
yum -y -q install tmux
yum -y -q install ncurses-devel
su - vagrant -c 'echo "source /opt/rh/rh-ruby23/enable" >> ~/.bashrc'
su - vagrant -c 'gem install bundler'