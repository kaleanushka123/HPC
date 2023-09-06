# INSTALLATION COMMANDS OF PXE BOOTING ON CENTOS 7.9

# First create an normal virtual machine.
# Go to virtual network editor (VM Editor)
# Select NAT(VM8)

# Scroll below box add your ip address of network you want (EX: 192.168.100.0)

# Uncheck DHCP Option

# APPLY and OK

# IN MASTER MACHINE
Check IP is available or not. If IP is unavailable then you need to up that ip with below command 
# ifup ens33

After this go to nmtui editor in same machine using command

# nmtui

# Edit

# Select ens33

With the help of keybord select
# Manual

# Adress that you provide before in vm editor

# Gateway:

# Save

# EX: 
# Address: 192.168.100.100
# Gateways: 192.168.100.2



# ON THE SAME MACHINE

# ip a

# systemctl status network

# systemctl start network

# vim /etc/resolv.conf

edit this file with below line

            nameserver 192.168.100.2          (this is DNS)
Save        :wq

ping www.google.com

# yum install syslinux xientd tftp-server

# mkdir /var/lib/tftboot/pxelinux.cfg

# ll /usr/share/syslinux/

# cp /usr/share/syslinux/pxebooting/ /var/lib/tftpboot/

# ll /var/lib/tftpboot/

# vim /etc/xinetd.d/tftp
            disable = no
            
# yum install dhcp

# vim /etc/dhcp/dhcpd.conf
        edit this file with below

        {
        subnet 192.168.100.0 netmask 255.255.255.0
        option domain-name-servers   master
        default-lease-time 600;
        max-lease-time 7200;
        range 192.168.100.105 - 192.168.100.120;
        optiona routers 192.168.100.100;
# add follows near line 8 (specify PXE server's hostname or IP for "next-server")
        filename        "pxelinux.0";
        next-server     192.168.100.100;      (tftp serer ip)
        }
# Save this file  :wq

then come to the terminal

# dhcpd -t

# systemctl restart dhcp
# mkdir -p /var/pxe/centos7/
# mkdir -p /var/lib/tftpboot/centos7
# df -Th
          check centos available
# mount -t iso 9660 -o loop /home/hpc1/dowloads/isofile/centos7.iso  /var/pxe/centos7/
# ls /var/pxe/centos7/
# cp /var/pxe/centos7/images/pxeboot/vmlinuz  /var/lib/tftpboot/centos7/
# cp /var/pxe/centos7/images/pxeboot/initrd.img  /var/lib/tftpboot/centos7/
# cp /usr/share/syslinux/menu.c32 /var/lib/tftpboot

# vim /var/lib/tftpboot/pxelinux.cfg/default
    #Creating PXE definition
      timeout 100
      default menu.c32

      menu title ########## PXE Boot Menu ##########
      label 1
      menu label ^1) Install CentOS 7
      kernel centos7/vmlinuz
      append initrd=centos7/initrd.img method=http://192.168.100.100/centos7 devfs=nomount

      label 2
      menu label ^2) Boot from local drive
      localboot

:wq

# ip a
# systemctl status httpd
# systemctl restart httpd
# systemctl enable httpd

 # Go To the browser search 
 http://192.168.100.100/centos7
