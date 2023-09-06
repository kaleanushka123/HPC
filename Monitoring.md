# htpasswd -bc /etc/nagios/passwd nagiosadmin nagiosadmin
	Adding passwd for nagiosadmin

# systemctl enable nagios.service
# systemctl restart nagios.service

# vim /etc/nagios/objects/localhost.cfg


***************Nagios********************
# systemctl stop firewalld.service
# systemctl disable firewalld.service
# systemctl status firewalld.service

# yum install yum-utils
# yum install epel-release

# yum -y install yum-utils
# wget -P /etc/yum.repos.d https://xcat.org/files/xcat/repos/yum/latest/xcat-core/xcat-core.repo --no-check-certificate

# wget -P /etc/yum.repos.d https://xcat.org/files/xcat/repos/yum/xcat-dep/rh7/x86_64/xcat-dep.repo --no-check-certificate

# Install opernhpc repository from below command
# yum install http://build.openhpc.community/OpenHPC:/1.3/CentOS_7/x86_64/ohpc-release-1.3-1.el7.x86_64.rpm

# Install Nagios 
# yum -y install ohpc-nagios

# cd /etc/nagios/
# htpasswd -bc /etc/nagios/passwd nagiosadmin nagiosadmin
# systemctl start nagios
# systemctl status nagios
# systemctl enable nagios
# systemctl status httpd


# Take Machine Ip and put in Web browser 

	http://192.168.20.137/nagios/



# ON CLIENT MACHINE

		# yum install nagios.plugins.all.ohpcs nrpe.ohpc
