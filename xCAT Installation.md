
# xCAT Stateless installation process
Install CentOs7 version 7.9

`yum update -y`

`yum upgrade -y`

`hostnamectl set-hostname xCAT`

         Entry add both machine name and IP address in /etc/hosts file

`vi /etc/hosts`

            10.10.10.2 xCAT

`vi /etc/selinux/config 

`systemctl stop firewalld.service`

`systemctl disable firewalld.service`

`systemctl status firewalld.service`

`yum install yum-utils`

`yum install epel-release`

`yum -y install yum-utils`
                  
`wget -P /etc/yum.repos.d https://xcat.org/files/xcat/repos/yum/latest/xcat-core/xcat-core.repo --no-check-certificate`                  
`wget -P /etc/yum.repos.d https://xcat.org/files/xcat/repos/yum/xcat-dep/rh7/x86_64/xcat-dep.repo --no-check-certificate`
                  
`yum -y install xCAT`
                  
`cat /etc/profile.d/xcat.sh`
                  
`source /etc/profile.d/xcat.sh`
                  
                  If you want to change master ip in tab site
 `#chdef -t site xcat=10.10.10.3 comment`                  
`lsdef -t osimage`
                   
`lsblk` ( If you are not able to see sr0 OS image then check
                           then check DVD is connected or not to Vmware                   
`dd if=/dev/sr0 of=centos.iso`



* Copy the centos.iso image (presumably CentOS installation ISO) to a directory.
  
`copycds centos.iso`

* List the defined OS image definitions.
                     
`lsdef -t osimage`

*Define the OS path for the CentOS installation. 
                   `OS Path ------------>/install/centos7.9/x86_64`
                   
* List the details of a specific OS image definition (centos7.9-x86_64-netboot-compute).
                  
`lsdef -t osimage centos7.9-x86_64-netboot-compute`

* Generate the image for the specified OS image definition.
  
`genimage centos7.9-x86_64-netboot-compute`

* Change the current directory to the location of the generated image.
  
`cd /install/netboot/centos7.9/x86_64/compute/`

* Create a directory for custom netboot images.
  
`mkdir -p /install/custom/netboot`

* Modify the OS image definition to include a synchronization list.
  
`chdef -t osimage centos7.9-x86_64-netboot-compute synclists="/install/custom/netboot/compute.synclist"`

* List the details of the modified OS image definition.
  
`lsdef -t osimage centos7.9-x86_64-netboot-compute`

* Open and edit the synchronization list file for custom netboot image.
  
`vim /install/custom/netboot/compute.synclist`

* Display the contents of the synchronization list file.
  
`cat /install/custom/netboot/compute.synclist`

* List the defined OS image definitions.
  
`lsdef -t osimage`

* Package the modified image.
  
`packimage centos7.9-x86_64-netboot-compute`


* Define a new node (cn00) with specified attributes.
  
`mkdef -t node cn00 groups=compute,all ip=10.10.10.3 mac=00:0c:29:98:93:43 netboot=xnba`

* List the details of the defined node (cn00).
`lsdef cn00`

* Change the site definition to set the domain as cdac.in.
`chdef -t site domain=cdac.in`

* Display the domain setting in the site definition.
`tabdump site | grep domain`
                  
* Update the hosts file with entries for the master and node.
`makehosts`
                  
`vim /etc/hosts`
                  
`cat /etc/hosts`
                  
                  127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
                  ::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
                  10.10.10.2 master master.cdac.in (xcat domain added)
                  10.10.10.3 cn00 cn00.cdac.in
                  
                  :wq save file
                  
Run the makenetworks command.                
`makenetworks`

Generate DHCP configuration.
`makedhcp -n`

Display the contents of the DHCP configuration file.
`cat /etc/dhcp/dhcpd.conf`

Generate DNS configuration.
`makedns -n`

Set the OS image for the compute node(s) to centos7.9-x86_64-netboot-compute.
`nodeset compute osimage=centos7.9-x86_64-netboot-compute`

Change the site definition to specify the DHCP interface.
 `chdef -t site dhcpinterfaces=ens37`

Restart the xCAT management daemon (xcatd).
`restart xcatd`

Enter a chroot environment for the specified root image.                  
`chroot /install/netboot/centos7.9/x86_64/compute/rootimg`
                   
`mkdir test`      
`cd test`
`vi test.txt`     
`exit`                  
`ssh cn00`
                  
# On second machine check file found
                  
# On master machine
                  
`yum --installroot=/install/netboot/centos7.9/x86_64/compute/rootimg install`
                  
`echo /install/netboot/centos7.9/x86_64/compute/rootimg`
                  
`yum --installroot=/install/netboot/centos7.9/x86_64/compute/rootimg install vim`
                  
`packimage centos7.9-x86_64-netboot-compute`
                  
                  
                  
                  
# TO MAKE CLONE OF IMAGE
                  
`imgaexport centos7.9-x86_64-netboot-compute`
                  
`ls`
                  
`imgimport centos7.9-x86_64-netboot-compute.tgz -f compute-bk` (computer name of clone image)
                  
`lsdef -t osimage`
                  
`lsdef cn00`

`chdef -t provmethod=compute-bk`
                  
`lsdef cn00`
                  

Transaction Summary
=============================================================================================================================================================================================

* yum install epel-release -y
  
* [root@master ~]# wget -P /etc/yum.repos.d https://xcat.org/files/xcat/repos/yum/latest/xcat-core/xcat-core.repo --no-check-certificate
  
* [root@master ~]# wget -P /etc/yum.repos.d https://xcat.org/files/xcat/repos/yum/xcat-dep/rh7/x86_64/xcat-dep.repo --no-check-certificate

* [root@master ~]# yum -y install xCAT

* [root@master ~]# cat /etc/pro
  
                  profile    profile.d/ protocols
   
* [root@master ~]# cat /etc/pro
  
                  profile    profile.d/ protocols
  
* [root@master ~]# cat /etc/profile.d/xcat.sh
  
                  XCATROOT=/opt/xcat
                  PATH=$XCATROOT/bin:$XCATROOT/sbin:$XCATROOT/share/xcat/tools:$PATH
                  MANPATH=$XCATROOT/share/man:$MANPATH
                  export XCATROOT PATH MANPATH
                  export PERL_BADLANG=0
                  # If /usr/local/share/perl5 is not already in @INC, add it to PERL5LIB
                  perl -e "print \"@INC\"" | egrep "(^|\W)/usr/local/share/perl5($| )" > /dev/null
                  if [ $? = 1 ]; then
                      export PERL5LIB=/usr/local/share/perl5:$PERL5LIB
                  fi
  
* [root@master ~]# source /etc/profile.d/xcat.sh
  
* [root@master ~]# lsdef -t osimage
  
                  Could not find any object definitions to display.
  
* [root@master ~]# lsblk
  
                  NAME            MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
                  sda               8:0    0  100G  0 disk 
                  ├─sda1            8:1    0    1G  0 part /boot
                  └─sda2            8:2    0   99G  0 part 
                    ├─centos-root 253:0    0   50G  0 lvm  /
                    ├─centos-swap 253:1    0  4.5G  0 lvm  [SWAP]
                    └─centos-home 253:2    0 44.5G  0 lvm  /home
                  sr0              11:0    1 1024M  0 rom
    
* [root@master ~]# dd if=/dev/sr0 of=centos.iso
  
                  dd: failed to open ‘/dev/sr0’: No medium found
  
* [root@master ~]# ll /dev/sr0
   
                  brw-rw----+ 1 root cdrom 11, 0 Jun  3 11:18 /dev/sr0
  
* [root@master ~]# lsdef -t osimage
  
                  Could not find any object definitions to display.
  
* [root@master ~]# lsblk
  
                  NAME            MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
                  sda               8:0    0  100G  0 disk 
                  ├─sda1            8:1    0    1G  0 part /boot
                  └─sda2            8:2    0   99G  0 part 
                    ├─centos-root 253:0    0   50G  0 lvm  /
                    ├─centos-swap 253:1    0  4.5G  0 lvm  [SWAP]
                    └─centos-home 253:2    0 44.5G  0 lvm  /home
                  sr0              11:0    1 1024M  0 rom
   
* [root@master ~]# copycds centos.iso
  
                  Error: [master]: The management server was unable to find/read /root/centos.iso. Ensure that file exists on the server at the specified location.

* [root@master ~]# lsdef -t osimage
  
                  Could not find any object definitions to display.
  
* [root@master ~]# lsblk
  
                  NAME            MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
                  sda               8:0    0  100G  0 disk 
                  ├─sda1            8:1    0    1G  0 part /boot
                  └─sda2            8:2    0   99G  0 part 
                    ├─centos-root 253:0    0   50G  0 lvm  /
                    ├─centos-swap 253:1    0  4.5G  0 lvm  [SWAP]
                    └─centos-home 253:2    0 44.5G  0 lvm  /home
                  sr0              11:0    1 1024M  0 rom  
* [root@master ~]# lsblk
  
                  NAME            MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
                  sda               8:0    0  100G  0 disk 
                  ├─sda1            8:1    0    1G  0 part /boot
                  └─sda2            8:2    0   99G  0 part 
                    ├─centos-root 253:0    0   50G  0 lvm  /
                    ├─centos-swap 253:1    0  4.5G  0 lvm  [SWAP]
                    └─centos-home 253:2    0 44.5G  0 lvm  /home
                  sr0              11:0    1  4.4G  0 rom  /run/media/master/CentOS 7 x86_64
  
* [root@master ~]# lsdef -t osimage
  
                  Could not find any object definitions to display.
  
* [root@master ~]# dd if=/dev/sr0 of=centos.iso
  
                  9203712+0 records in
                  9203712+0 records out
                  4712300544 bytes (4.7 GB) copied, 78.4984 s, 60.0 MB/s
  
* [root@master ~]# copycds centos.iso
  
                  Copying media to /install/centos7.9/x86_64
                  Media copy operation successful
  
* [root@master ~]# lsdef -t osimage
  
                  centos7.9-x86_64-install-compute  (osimage)
                  centos7.9-x86_64-netboot-compute  (osimage)
                  centos7.9-x86_64-statelite-compute  (osimage)
  
* [root@master ~]# lsdef -t osimage centos7.9-x86_64-netboot-compute
  
                  Object name: centos7.9-x86_64-netboot-compute
                      exlist=/opt/xcat/share/xcat/netboot/centos/compute.centos7.exlist
                      imagetype=linux
                      osarch=x86_64
                      osdistroname=centos7.9-x86_64
                      osname=Linux
                      osvers=centos7.9
                      otherpkgdir=/install/post/otherpkgs/centos7.9/x86_64
                      pkgdir=/install/centos7.9/x86_64
                      pkglist=/opt/xcat/share/xcat/netboot/centos/compute.centos7.pkglist
                      postinstall=/opt/xcat/share/xcat/netboot/centos/compute.centos7.postinstall
                      profile=compute
                      provmethod=netboot
                      rootimgdir=/install/netboot/centos7.9/x86_64/compute
  
* [root@master ~]# genimage centos7.9-x86_64-netboot-compute
  
                  Generating image: 
                                    cd /opt/xcat/share/xcat/netboot/centos; ./genimage -a x86_64 -o centos7.9 -p compute --srcdir "/install/centos7.9/x86_64" --pkglist /opt/xcat/share/xcat/netboot/centos/compute.centos7.pkglist --                           otherpkgdir "/install/post/otherpkgs/centos7.9/x86_64" --postinstall "/opt/xcat/share/xcat/netboot/centos/compute.centos7.postinstall" --rootimgdir /install/netboot/centos7.9/x86_64/compute --                           tempfile /tmp/xcat_genimage.14398 centos7.9-x86_64-netboot-compute
                                    112 blocks
                                    /opt/xcat/share/xcat/netboot/centos
                                    112 blocks
                                    /opt/xcat/share/xcat/netboot/centos
                                     yum -y -c /tmp/genimage.14413.yum.conf --installroot=/install/netboot/centos7.9/x86_64/compute/rootimg/ --disablerepo=* --enablerepo=centos7.9-x86_64-0  install  bash dracut-network nfs-utils openssl                    
                                    Complete!
                  
                                    /usr/lib/dracut/dracut-install -D /var/tmp/dracut.79Klu6/initramfs -a parted mke2fs bc mkswap swapon chmod mkfs mkfs.ext4 mkfs.xfs xfs_db
                                    grep: /etc/udev/rules.d/*: No such file or directory
                                    the initial ramdisk for statelite is generated successfully.
* [root@master ~]# cd /install/netboot/centos7.9/x86_64/compute/

* [root@master compute]# mkdir -p /install/custom/netboot

* [root@master compute]#  chdef -t osimage centos7.9-x86_64-netboot-compute synclists="/install/custom/netboot/compute.synclist"

              1 object definitions have been created or modified.
  
* [root@master compute]# lsdef -t osimage centos7.9-x86_64-netboot-compute
  
                  Object name: centos7.9-x86_64-netboot-compute
                      exlist=/opt/xcat/share/xcat/netboot/centos/compute.centos7.exlist
                      imagetype=linux
                      osarch=x86_64
                      osdistroname=centos7.9-x86_64
                      osname=Linux
                      osvers=centos7.9
                      otherpkgdir=/install/post/otherpkgs/centos7.9/x86_64
                      permission=755
                      pkgdir=/install/centos7.9/x86_64
                      pkglist=/opt/xcat/share/xcat/netboot/centos/compute.centos7.pkglist
                      postinstall=/opt/xcat/share/xcat/netboot/centos/compute.centos7.postinstall
                      profile=compute
                      provmethod=netboot
                      rootimgdir=/install/netboot/centos7.9/x86_64/compute
                      synclists=/install/custom/netboot/compute.synclist
  
* [root@master compute]# vim /install/custom/netboot/compute.synclist
* 
* [root@master compute]# cat /install/custom/netboot/compute.synclist
* 
                  cat: /install/custom/netboot/compute.synclist: No such file or directory
  
* [root@master compute]# lsdef -t osimage
  
                  centos7.9-x86_64-install-compute  (osimage)
                  centos7.9-x86_64-netboot-compute  (osimage)
                  centos7.9-x86_64-statelite-compute  (osimage)
  
* [root@master compute]# packimage centos7.9-x86_64-netboot-compute
  
                  Packing contents of /install/netboot/centos7.9/x86_64/compute/rootimg
                  archive method:cpio
                  compress method:gzip

* [root@master compute]# mkdef -t node cn00 groups=compute,all ip=10.10.10.3 mac=00:0c:29:11:A6:49 netboot=xnba
  
                  1 object definitions have been created or modified.
  
* [root@master compute]# lsdef cn00
  
                     Object name: cn00
                      groups=compute,all
                      ip=10.10.10.3
                      mac=00:0c:29:11:A6:49
                      netboot=xnba
                      postbootscripts=otherpkgs
                      postscripts=syslog,remoteshell,syncfiles
  
* [root@master compute]# chdef -t site domain=cdac.in

                   1 object definitions have been created or modified.

* [root@master compute]# tabdump site | grep domain

                  "domain","cdac.in",,
  
* root@master compute]# makehosts

* [root@master compute]# vim /etc/hosts

* [root@master compute]# makenetworks

                  Warning: [master]: The network entry '10_10_10_0-255_255_255_0' already exists in xCAT networks table. Cannot create a definition for '10_10_10_0-255_255_255_0'
                  Warning: [master]: The network entry '192_168_20_0-255_255_255_0' already exists in xCAT networks table. Cannot create a definition for '192_168_20_0-255_255_255_0'
                  Warning: [master]: The network entry '192_168_122_0-255_255_255_0' already exists in xCAT networks table. Cannot create a definition for '192_168_122_0-255_255_255_0'

* [root@master compute]# makedhcp -n
  
                  Renamed existing dhcp configuration file to  /etc/dhcp/dhcpd.conf.xcatbak
                  
                  The dhcp server must be restarted for OMAPI function to work
                  Warning: [master]: No dynamic range specified for 10.10.10.0. If hardware discovery is being used, a dynamic range is required.
                  Warning: [master]: No dynamic range specified for 192.168.20.0. If hardware discovery is being used, a dynamic range is required.
                  Warning: [master]: No dynamic range specified for 192.168.122.0. If hardware discovery is being used, a dynamic range is required.
  
* [root@master compute]# cat /etc/dhcp/dhcpd.conf
  
* xCAT generated dhcp configuration

                  option conf-file code 209 = text;
                  option space isan;
                  option isan-encap-opts code 43 = encapsulate isan;
                  option isan.iqn code 203 = string;
                  option isan.root-path code 201 = string;
                  option space gpxe;
                  option gpxe-encap-opts code 175 = encapsulate gpxe;
                  option gpxe.bus-id code 177 = string;
                  option user-class-identifier code 77 = string;
                  option gpxe.no-pxedhcp code 176 = unsigned integer 8;
                  option tcode code 101 = text;
                  option iscsi-initiator-iqn code 203 = string;
                  ddns-update-style interim;
                  ignore client-updates;
                  option client-architecture code 93 = unsigned integer 16;
                  option tcode "America/New_York";
                  option gpxe.no-pxedhcp 1;
                  option www-server code 114 = string;
                  option cumulus-provision-url code 239 = text;
                  
                  omapi-port 7911;
                  key xcat_key {
                    algorithm hmac-md5;
                    secret "QWlUbTRod1A0eEpWeHpGeWllaFpuMlgyenM4MmkwaUg=";
                  };
                  omapi-key xcat_key;
                  class "pxe" {
                     match if substring (option vendor-class-identifier, 0, 9) = "PXEClient";
                     ddns-updates off;
                      max-lease-time 600;
                  }
                  shared-network ens37 {
                    subnet 10.10.10.0 netmask 255.255.255.0 {
                      authoritative;
                      max-lease-time 43200;
                      min-lease-time 43200;
                      default-lease-time 43200;
                      option routers  10.10.10.129;
                      next-server  10.10.10.129;
                      option log-servers 10.10.10.129;
                      option ntp-servers 10.10.10.129;
                      option domain-name "cdac.in";
                      option domain-name-servers  10.10.10.2;
                      option interface-mtu 1500;
                      option domain-search  "cdac.in";
                      option cumulus-provision-url "http://10.10.10.129:80/install/postscripts/cumulusztp";
                      zone cdac.in. {
                         primary 10.10.10.2; key xcat_key; 
                      }
                      zone 10.10.10.IN-ADDR.ARPA. {
                         primary 10.10.10.2; key xcat_key; 
                      }
                      if option user-class-identifier = "xNBA" and option client-architecture = 00:00 { #x86, xCAT Network Boot Agent
                          always-broadcast on;
                          filename = "http://10.10.10.129:80/tftpboot/xcat/xnba/nets/10.10.10.0_24";
                      } else if option user-class-identifier = "xNBA" and option client-architecture = 00:09 { #x86, xCAT Network Boot Agent
                          filename = "http://10.10.10.129:80/tftpboot/xcat/xnba/nets/10.10.10.0_24.uefi";
                      } else if option client-architecture = 00:00  { #x86
                          filename "xcat/xnba.kpxe";
                      } else if option vendor-class-identifier = "Etherboot-5.4"  { #x86
                          filename "xcat/xnba.kpxe";
                      } else if option client-architecture = 00:07 { #x86_64 uefi
                           filename "xcat/xnba.efi";
                      } else if option client-architecture = 00:09 { #x86_64 uefi alternative id
                           filename "xcat/xnba.efi";
                      } else if option client-architecture = 00:02 { #ia64
                           filename "elilo.efi";
                      } else if option client-architecture = 00:0e { #OPAL-v3
                           option conf-file = "http://10.10.10.129:80/tftpboot/pxelinux.cfg/p/10.10.10.0_24";
                      } else if substring (option vendor-class-identifier,0,11) = "onie_vendor" { #for onie on cumulus switch
                          option www-server = "http://10.10.10.129:80/install/onie/onie-installer";
                      } else if substring(filename,0,1) = null { #otherwise, provide yaboot if the client isn't specific
                           filename "/yaboot";
                      }
                    } # 10.10.10.0/255.255.255.0 subnet_end
                  } # ens37 nic_end
                  shared-network ens33 {
                    subnet 192.168.20.0 netmask 255.255.255.0 {
                      authoritative;
                      max-lease-time 43200;
                      min-lease-time 43200;
                      default-lease-time 43200;
                      option routers  192.168.20.2;
                      next-server  192.168.20.131;
                      option log-servers 192.168.20.131;
                      option ntp-servers 192.168.20.131;
                      option domain-name "cdac.in";
                      option domain-name-servers  10.10.10.2;
                      option interface-mtu 1500;
                      option domain-search  "cdac.in";
                      option cumulus-provision-url "http://192.168.20.131:80/install/postscripts/cumulusztp";
                      zone cdac.in. {
                         primary 10.10.10.2; key xcat_key; 
                      }
                      zone 20.168.192.IN-ADDR.ARPA. {
                         primary 10.10.10.2; key xcat_key; 
                      }
                      if option user-class-identifier = "xNBA" and option client-architecture = 00:00 { #x86, xCAT Network Boot Agent
                          always-broadcast on;
                          filename = "http://192.168.20.131:80/tftpboot/xcat/xnba/nets/192.168.20.0_24";
                      } else if option user-class-identifier = "xNBA" and option client-architecture = 00:09 { #x86, xCAT Network Boot Agent
                          filename = "http://192.168.20.131:80/tftpboot/xcat/xnba/nets/192.168.20.0_24.uefi";
                      } else if option client-architecture = 00:00  { #x86
                          filename "xcat/xnba.kpxe";
                      } else if option vendor-class-identifier = "Etherboot-5.4"  { #x86
                          filename "xcat/xnba.kpxe";
                      } else if option client-architecture = 00:07 { #x86_64 uefi
                           filename "xcat/xnba.efi";
                      } else if option client-architecture = 00:09 { #x86_64 uefi alternative id
                           filename "xcat/xnba.efi";
                      } else if option client-architecture = 00:02 { #ia64
                           filename "elilo.efi";
                      } else if option client-architecture = 00:0e { #OPAL-v3
                           option conf-file = "http://192.168.20.131:80/tftpboot/pxelinux.cfg/p/192.168.20.0_24";
                      } else if substring (option vendor-class-identifier,0,11) = "onie_vendor" { #for onie on cumulus switch
                          option www-server = "http://192.168.20.131:80/install/onie/onie-installer";
                      } else if substring(filename,0,1) = null { #otherwise, provide yaboot if the client isn't specific
                           filename "/yaboot";
                      }
                    } # 192.168.20.0/255.255.255.0 subnet_end
                  } # ens33 nic_end
                  shared-network virbr0 {
                    subnet 192.168.122.0 netmask 255.255.255.0 {
                      authoritative;
                      max-lease-time 43200;
                      min-lease-time 43200;
                      default-lease-time 43200;
                      option routers  192.168.122.1;
                      next-server  192.168.122.1;
                      option log-servers 192.168.122.1;
                      option ntp-servers 192.168.122.1;
                      option domain-name "cdac.in";
                      option domain-name-servers  10.10.10.2;
                      option interface-mtu 1500;
                      option domain-search  "cdac.in";
                      option cumulus-provision-url "http://192.168.122.1:80/install/postscripts/cumulusztp";
                      zone cdac.in. {
                         primary 10.10.10.2; key xcat_key; 
                      }
                      zone 122.168.192.IN-ADDR.ARPA. {
                         primary 10.10.10.2; key xcat_key; 
                      }
                      if option user-class-identifier = "xNBA" and option client-architecture = 00:00 { #x86, xCAT Network Boot Agent
                          always-broadcast on;
                          filename = "http://192.168.122.1:80/tftpboot/xcat/xnba/nets/192.168.122.0_24";
                      } else if option user-class-identifier = "xNBA" and option client-architecture = 00:09 { #x86, xCAT Network Boot Agent
                          filename = "http://192.168.122.1:80/tftpboot/xcat/xnba/nets/192.168.122.0_24.uefi";
                      } else if option client-architecture = 00:00  { #x86
                          filename "xcat/xnba.kpxe";
                      } else if option vendor-class-identifier = "Etherboot-5.4"  { #x86
                          filename "xcat/xnba.kpxe";
                      } else if option client-architecture = 00:07 { #x86_64 uefi
                           filename "xcat/xnba.efi";
                      } else if option client-architecture = 00:09 { #x86_64 uefi alternative id
                           filename "xcat/xnba.efi";
                      } else if option client-architecture = 00:02 { #ia64
                           filename "elilo.efi";
                      } else if option client-architecture = 00:0e { #OPAL-v3
                           option conf-file = "http://192.168.122.1:80/tftpboot/pxelinux.cfg/p/192.168.122.0_24";
                      } else if substring (option vendor-class-identifier,0,11) = "onie_vendor" { #for onie on cumulus switch
                          option www-server = "http://192.168.122.1:80/install/onie/onie-installer";
                      } else if substring(filename,0,1) = null { #otherwise, provide yaboot if the client isn't specific
                           filename "/yaboot";
                      }
                    } # 192.168.122.0/255.255.255.0 subnet_end
                  } # virbr0 nic_end
  
* [root@master compute]# makedns -n

* [root@master compute]# nodeset compute osimage=centos7.9-x86_64-netboot-compute

            cn00: netboot centos7.9-x86_64-compute
  
* [root@master compute]# vim /etc/hosts
* [root@master compute]# tabdumb
  
                  bash: tabdumb: command not found...
  
* [root@master compute]# tabdump
  
                  auditlog
                  bootparams
                  boottarget
                  cfgmgt
                  chain
                  deps
                  discoverydata
                  domain
                  eventlog
                  firmware
                  hosts
                  hwinv
                  hypervisor
                  ipmi
                  iscsi
                  kit
                  kitcomponent
                  kitrepo
                  kvm_masterdata
                  kvm_nodedata
                  linuximage
                  litefile
                  litetree
                  mac
                  mic
                  monitoring
                  monsetting
                  mp
                  mpa
                  networks
                  nics
                  nimimage
                  nodegroup
                  nodehm
                  nodelist
                  nodepos
                  noderes
                  nodetype
                  notification
                  openbmc
                  osdistro
                  osdistroupdate
                  osimage
                  passwd
                  pdu
                  pduoutlet
                  performance
                  policy
                  postscripts
                  ppc
                  ppcdirect
                  ppchcp
                  prescripts
                  prodkey
                  rack
                  routes
                  servicenode
                  site
                  statelite
                  storage
                  switch
                  switches
                  taskstate
                  token
                  virtsd
                  vm
                  vmmaster
                  vpd
                  websrv
                  winimage
                  zone
                  zvm
                  zvmivp

* [root@master compute]# tabdump site
  
                  #key,value,comments,disable
                  "blademaxp","64",,
                  "fsptimeout","0",,
                  "installdir","/install",,
                  "ipmimaxp","64",,
                  "ipmiretries","3",,
                  "ipmitimeout","2",,
                  "consoleondemand","no",,
                  "master","10.10.10.2",,
                  "forwarders","192.168.20.2,10.10.10.1",,
                  "nameservers","10.10.10.2",,
                  "maxssh","8",,
                  "ppcmaxp","64",,
                  "ppcretry","3",,
                  "ppctimeout","0",,
                  "powerinterval","0",,
                  "syspowerinterval","0",,
                  "sharedtftp","1",,
                  "SNsyncfiledir","/var/xcat/syncfiles",,
                  "nodesyncfiledir","/var/xcat/node/syncfiles",,
                  "tftpdir","/tftpboot",,
                  "xcatdport","3001",,
                  "xcatiport","3002",,
                  "xcatconfdir","/etc/xcat",,
                  "timezone","America/New_York",,
                  "useNmapfromMN","no",,
                  "enableASMI","no",,
                  "db2installloc","/mntdb2",,
                  "databaseloc","/var/lib",,
                  "sshbetweennodes","ALLGROUPS",,
                  "dnshandler","ddns",,
                  "vsftp","n",,
                  "cleanupxcatpost","no",,
                  "cleanupdiskfullxcatpost","no",,
                  "dhcplease","43200",,
                  "auditnosyslog","0",,
                  "auditskipcmds","ALL",,
                  "domain","cdac.in",,
                  [root@master compute]# sysstemctl status network
                  bash: sysstemctl: command not found...
                  Similar command is: 'systemctl'
  
* [root@master compute]# systemctl status network
  
                  ● network.service - LSB: Bring up/down networking
                     Loaded: loaded (/etc/rc.d/init.d/network; bad; vendor preset: disabled)
                     Active: active (exited) since Sat 2023-06-03 11:19:03 EDT; 1 day 13h ago
                       Docs: man:systemd-sysv-generator(8)
                      Tasks: 0
                  
                  Jun 03 11:19:02 localhost.localdomain systemd[1]: Starting LSB: Bring up/down networking...
                  Jun 03 11:19:03 localhost.localdomain network[1214]: Bringing up loopback interface:  [  OK  ]
                  Jun 03 11:19:03 localhost.localdomain network[1214]: Bringing up interface ens33:  [  OK  ]
                  Jun 03 11:19:03 localhost.localdomain systemd[1]: Started LSB: Bring up/down networking.
                  [root@master compute]# ifup ens37
                  /sbin/ifup: configuration for ens37 not found.
                  Usage: ifup <configuration>
  
* [root@master compute]# ifup ens36
  
                  /sbin/ifup: configuration for ens36 not found.
                  Usage: ifup <configuration>
  
* [root@master compute]# ip a

* [root@master compute]# makehosts
  
* [root@master compute]# makenetworks

* [root@master compute]# makedns -n

* [root@master compute]# chdef -t site dhcpinterfaces=ens37
  
                  1 object definitions have been created or modified.
  
* [root@master compute]# tabdump site
  
                  #key,value,comments,disable
                  "blademaxp","64",,
                  "fsptimeout","0",,
                  "installdir","/install",,
                  "ipmimaxp","64",,
                  "ipmiretries","3",,
                  "ipmitimeout","2",,
                  "consoleondemand","no",,
                  "master","10.10.10.2",,
                  "forwarders","192.168.20.2,10.10.10.1",,
                  "nameservers","10.10.10.2",,
                  "maxssh","8",,
                  "ppcmaxp","64",,
                  "ppcretry","3",,
                  "ppctimeout","0",,
                  "powerinterval","0",,
                  "syspowerinterval","0",,
                  "sharedtftp","1",,
                  "SNsyncfiledir","/var/xcat/syncfiles",,
                  "nodesyncfiledir","/var/xcat/node/syncfiles",,
                  "tftpdir","/tftpboot",,
                  "xcatdport","3001",,
                  "xcatiport","3002",,
                  "xcatconfdir","/etc/xcat",,
                  "timezone","America/New_York",,
                  "useNmapfromMN","no",,
                  "enableASMI","no",,
                  "db2installloc","/mntdb2",,
                  "databaseloc","/var/lib",,
                  "sshbetweennodes","ALLGROUPS",,
                  "dnshandler","ddns",,
                  "vsftp","n",,
                  "cleanupxcatpost","no",,
                  "cleanupdiskfullxcatpost","no",,
                  "dhcplease","43200",,
                  "auditnosyslog","0",,
                  "auditskipcmds","ALL",,
                  "domain","cdac.in",,
                  "dhcpinterfaces","ens37",,


 * [root@master compute]# nodeset compute osimage=centos7.9-x86_64-netboot-compute
   
                  cn00: netboot centos7.9-x86_64-compute
   
* [root@master compute]# cat /etc/dhcp/dhcpd.conf
  
* xCAT generated dhcp configuration

                  option conf-file code 209 = text;
                  option space isan;
                  option isan-encap-opts code 43 = encapsulate isan;
                  option isan.iqn code 203 = string;
                  option isan.root-path code 201 = string;
                  option space gpxe;
                  option gpxe-encap-opts code 175 = encapsulate gpxe;
                  option gpxe.bus-id code 177 = string;
                  option user-class-identifier code 77 = string;
                  option gpxe.no-pxedhcp code 176 = unsigned integer 8;
                  option tcode code 101 = text;
                  option iscsi-initiator-iqn code 203 = string;
                  ddns-update-style interim;
                  ignore client-updates;
                  option client-architecture code 93 = unsigned integer 16;
                  option tcode "America/New_York";
                  option gpxe.no-pxedhcp 1;
                  option www-server code 114 = string;
                  option cumulus-provision-url code 239 = text;
                  
                  omapi-port 7911;
                  key xcat_key {
                    algorithm hmac-md5;
                    secret "QWlUbTRod1A0eEpWeHpGeWllaFpuMlgyenM4MmkwaUg=";
                  };
                  omapi-key xcat_key;
                  class "pxe" {
                     match if substring (option vendor-class-identifier, 0, 9) = "PXEClient";
                     ddns-updates off;
                      max-lease-time 600;
                  }
                  shared-network ens37 {
                    subnet 10.10.10.0 netmask 255.255.255.0 {
                      authoritative;
                      max-lease-time 43200;
                      min-lease-time 43200;
                      default-lease-time 43200;
                      option routers  10.10.10.129;
                      next-server  10.10.10.129;
                      option log-servers 10.10.10.129;
                      option ntp-servers 10.10.10.129;
                      option domain-name "cdac.in";
                      option domain-name-servers  10.10.10.2;
                      option interface-mtu 1500;
                      option domain-search  "cdac.in";
                      option cumulus-provision-url "http://10.10.10.129:80/install/postscripts/cumulusztp";
                      zone cdac.in. {
                         primary 10.10.10.2; key xcat_key; 
                      }
                      zone 10.10.10.IN-ADDR.ARPA. {
                         primary 10.10.10.2; key xcat_key; 
                      }
                      if option user-class-identifier = "xNBA" and option client-architecture = 00:00 { #x86, xCAT Network Boot Agent
                          always-broadcast on;
                          filename = "http://10.10.10.129:80/tftpboot/xcat/xnba/nets/10.10.10.0_24";
                      } else if option user-class-identifier = "xNBA" and option client-architecture = 00:09 { #x86, xCAT Network Boot Agent
                          filename = "http://10.10.10.129:80/tftpboot/xcat/xnba/nets/10.10.10.0_24.uefi";
                      } else if option client-architecture = 00:00  { #x86
                          filename "xcat/xnba.kpxe";
                      } else if option vendor-class-identifier = "Etherboot-5.4"  { #x86
                          filename "xcat/xnba.kpxe";
                      } else if option client-architecture = 00:07 { #x86_64 uefi
                           filename "xcat/xnba.efi";
                      } else if option client-architecture = 00:09 { #x86_64 uefi alternative id
                           filename "xcat/xnba.efi";
                      } else if option client-architecture = 00:02 { #ia64
                           filename "elilo.efi";
                      } else if option client-architecture = 00:0e { #OPAL-v3
                           option conf-file = "http://10.10.10.129:80/tftpboot/pxelinux.cfg/p/10.10.10.0_24";
                      } else if substring (option vendor-class-identifier,0,11) = "onie_vendor" { #for onie on cumulus switch
                          option www-server = "http://10.10.10.129:80/install/onie/onie-installer";
                      } else if substring(filename,0,1) = null { #otherwise, provide yaboot if the client isn't specific
                           filename "/yaboot";
                      }
                    } # 10.10.10.0/255.255.255.0 subnet_end
                  } # ens37 nic_end
                  shared-network ens33 {
                    subnet 192.168.20.0 netmask 255.255.255.0 {
                      authoritative;
                      max-lease-time 43200;
                      min-lease-time 43200;
                      default-lease-time 43200;
                      option routers  192.168.20.2;
                      next-server  192.168.20.131;
                      option log-servers 192.168.20.131;
                      option ntp-servers 192.168.20.131;
                      option domain-name "cdac.in";
                      option domain-name-servers  10.10.10.2;
                      option interface-mtu 1500;
                      option domain-search  "cdac.in";
                      option cumulus-provision-url "http://192.168.20.131:80/install/postscripts/cumulusztp";
                      zone cdac.in. {
                         primary 10.10.10.2; key xcat_key; 
                      }
                      zone 20.168.192.IN-ADDR.ARPA. {
                         primary 10.10.10.2; key xcat_key; 
                      }
                      if option user-class-identifier = "xNBA" and option client-architecture = 00:00 { #x86, xCAT Network Boot Agent
                          always-broadcast on;
                          filename = "http://192.168.20.131:80/tftpboot/xcat/xnba/nets/192.168.20.0_24";
                      } else if option user-class-identifier = "xNBA" and option client-architecture = 00:09 { #x86, xCAT Network Boot Agent
                          filename = "http://192.168.20.131:80/tftpboot/xcat/xnba/nets/192.168.20.0_24.uefi";
                      } else if option client-architecture = 00:00  { #x86
                          filename "xcat/xnba.kpxe";
                      } else if option vendor-class-identifier = "Etherboot-5.4"  { #x86
                          filename "xcat/xnba.kpxe";
                      } else if option client-architecture = 00:07 { #x86_64 uefi
                           filename "xcat/xnba.efi";
                      } else if option client-architecture = 00:09 { #x86_64 uefi alternative id
                           filename "xcat/xnba.efi";
                      } else if option client-architecture = 00:02 { #ia64
                           filename "elilo.efi";
                      } else if option client-architecture = 00:0e { #OPAL-v3
                           option conf-file = "http://192.168.20.131:80/tftpboot/pxelinux.cfg/p/192.168.20.0_24";
                      } else if substring (option vendor-class-identifier,0,11) = "onie_vendor" { #for onie on cumulus switch
                          option www-server = "http://192.168.20.131:80/install/onie/onie-installer";
                      } else if substring(filename,0,1) = null { #otherwise, provide yaboot if the client isn't specific
                           filename "/yaboot";
                      }
                    } # 192.168.20.0/255.255.255.0 subnet_end
                  } # ens33 nic_end
                  shared-network virbr0 {
                    subnet 192.168.122.0 netmask 255.255.255.0 {
                      authoritative;
                      max-lease-time 43200;
                      min-lease-time 43200;
                      default-lease-time 43200;
                      option routers  192.168.122.1;
                      next-server  192.168.122.1;
                      option log-servers 192.168.122.1;
                      option ntp-servers 192.168.122.1;
                      option domain-name "cdac.in";
                      option domain-name-servers  10.10.10.2;
                      option interface-mtu 1500;
                      option domain-search  "cdac.in";
                      option cumulus-provision-url "http://192.168.122.1:80/install/postscripts/cumulusztp";
                      zone cdac.in. {
                         primary 10.10.10.2; key xcat_key; 
                      }
                      zone 122.168.192.IN-ADDR.ARPA. {
                         primary 10.10.10.2; key xcat_key; 
                      }
                      if option user-class-identifier = "xNBA" and option client-architecture = 00:00 { #x86, xCAT Network Boot Agent
                          always-broadcast on;
                          filename = "http://192.168.122.1:80/tftpboot/xcat/xnba/nets/192.168.122.0_24";
                      } else if option user-class-identifier = "xNBA" and option client-architecture = 00:09 { #x86, xCAT Network Boot Agent
                          filename = "http://192.168.122.1:80/tftpboot/xcat/xnba/nets/192.168.122.0_24.uefi";
                      } else if option client-architecture = 00:00  { #x86
                          filename "xcat/xnba.kpxe";
                      } else if option vendor-class-identifier = "Etherboot-5.4"  { #x86
                          filename "xcat/xnba.kpxe";
                      } else if option client-architecture = 00:07 { #x86_64 uefi
                           filename "xcat/xnba.efi";
                      } else if option client-architecture = 00:09 { #x86_64 uefi alternative id
                           filename "xcat/xnba.efi";
                      } else if option client-architecture = 00:02 { #ia64
                           filename "elilo.efi";
                      } else if option client-architecture = 00:0e { #OPAL-v3
                           option conf-file = "http://192.168.122.1:80/tftpboot/pxelinux.cfg/p/192.168.122.0_24";
                      } else if substring (option vendor-class-identifier,0,11) = "onie_vendor" { #for onie on cumulus switch
                          option www-server = "http://192.168.122.1:80/install/onie/onie-installer";
                      } else if substring(filename,0,1) = null { #otherwise, provide yaboot if the client isn't specific
                           filename "/yaboot";
                      }
                    } # 192.168.122.0/255.255.255.0 subnet_end
                  } # virbr0 nic_end
                  #definition for host cn00 aka host cn00 can be found in the dhcpd.leases file (typically /var/lib/dhcpd/dhcpd.leases)
# [root@master compute]# lsdef cn00
                  Object name: cn00
                      arch=x86_64
                      currstate=netboot centos7.9-x86_64-compute
                      groups=compute,all
                      ip=10.10.10.3
                      mac=00:0c:29:11:A6:49
                      netboot=xnba
                      os=centos7.9
                      postbootscripts=otherpkgs
                      postscripts=syslog,remoteshell,syncfiles
                      profile=compute
                      provmethod=centos7.9-x86_64-netboot-compute
                      
* [root@master compute]# makehosts
  
* [root@master compute]# makenetworks
  
                  Warning: [master]: The network entry '10_10_10_0-255_255_255_0' already exists in xCAT networks table. Cannot create a definition for '10_10_10_0-255_255_255_0'
                  Warning: [master]: The network entry '192_168_20_0-255_255_255_0' already exists in xCAT networks table. Cannot create a definition for '192_168_20_0-255_255_255_0'

* [root@master compute]# makedhcp -n
  
                  Renamed existing dhcp configuration file to  /etc/dhcp/dhcpd.conf.xcatbak

                  Warning: [master]: No dynamic range specified for 10.10.10.0. If hardware discovery is being used, a dynamic range is required.
  
* [root@master compute]#  cat /etc/dhcp/dhcpd.conf.xcatbak
  
* xCAT generated dhcp configuration
                  
                  option conf-file code 209 = text;
                  option space isan;
                  option isan-encap-opts code 43 = encapsulate isan;
                  option isan.iqn code 203 = string;
                  option isan.root-path code 201 = string;
                  option space gpxe;
                  option gpxe-encap-opts code 175 = encapsulate gpxe;
                  option gpxe.bus-id code 177 = string;
                  option user-class-identifier code 77 = string;
                  option gpxe.no-pxedhcp code 176 = unsigned integer 8;
                  option tcode code 101 = text;
                  option iscsi-initiator-iqn code 203 = string;
                  ddns-update-style interim;
                  ignore client-updates;
                  option client-architecture code 93 = unsigned integer 16;
                  option tcode "America/New_York";
                  option gpxe.no-pxedhcp 1;
                  option www-server code 114 = string;
                  option cumulus-provision-url code 239 = text;
                  
                  omapi-port 7911;
                  key xcat_key {
                    algorithm hmac-md5;
                    secret "QWlUbTRod1A0eEpWeHpGeWllaFpuMlgyenM4MmkwaUg=";
                  };
                  omapi-key xcat_key;
                  class "pxe" {
                     match if substring (option vendor-class-identifier, 0, 9) = "PXEClient";
                     ddns-updates off;
                      max-lease-time 600;
                  }
                  shared-network ens37 {
                    subnet 10.10.10.0 netmask 255.255.255.0 {
                      authoritative;
                      max-lease-time 43200;
                      min-lease-time 43200;
                      default-lease-time 43200;
                      option routers  10.10.10.129;
                      next-server  10.10.10.129;
                      option log-servers 10.10.10.129;
                      option ntp-servers 10.10.10.129;
                      option domain-name "cdac.in";
                      option domain-name-servers  10.10.10.2;
                      option interface-mtu 1500;
                      option domain-search  "cdac.in";
                      option cumulus-provision-url "http://10.10.10.129:80/install/postscripts/cumulusztp";
                      zone cdac.in. {
                         primary 10.10.10.2; key xcat_key; 
                      }
                      zone 10.10.10.IN-ADDR.ARPA. {
                         primary 10.10.10.2; key xcat_key; 
                      }
                      if option user-class-identifier = "xNBA" and option client-architecture = 00:00 { #x86, xCAT Network Boot Agent
                          always-broadcast on;
                          filename = "http://10.10.10.129:80/tftpboot/xcat/xnba/nets/10.10.10.0_24";
                      } else if option user-class-identifier = "xNBA" and option client-architecture = 00:09 { #x86, xCAT Network Boot Agent
                          filename = "http://10.10.10.129:80/tftpboot/xcat/xnba/nets/10.10.10.0_24.uefi";
                      } else if option client-architecture = 00:00  { #x86
                          filename "xcat/xnba.kpxe";
                      } else if option vendor-class-identifier = "Etherboot-5.4"  { #x86
                          filename "xcat/xnba.kpxe";
                      } else if option client-architecture = 00:07 { #x86_64 uefi
                           filename "xcat/xnba.efi";
                      } else if option client-architecture = 00:09 { #x86_64 uefi alternative id
                           filename "xcat/xnba.efi";
                      } else if option client-architecture = 00:02 { #ia64
                           filename "elilo.efi";
                      } else if option client-architecture = 00:0e { #OPAL-v3
                           option conf-file = "http://10.10.10.129:80/tftpboot/pxelinux.cfg/p/10.10.10.0_24";
                      } else if substring (option vendor-class-identifier,0,11) = "onie_vendor" { #for onie on cumulus switch
                          option www-server = "http://10.10.10.129:80/install/onie/onie-installer";
                      } else if substring(filename,0,1) = null { #otherwise, provide yaboot if the client isn't specific
                           filename "/yaboot";
                      }
                    } # 10.10.10.0/255.255.255.0 subnet_end
                  } # ens37 nic_end
                  shared-network ens33 {
                    subnet 192.168.20.0 netmask 255.255.255.0 {
                      authoritative;
                      max-lease-time 43200;
                      min-lease-time 43200;
                      default-lease-time 43200;
                      option routers  192.168.20.2;
                      next-server  192.168.20.131;
                      option log-servers 192.168.20.131;
                      option ntp-servers 192.168.20.131;
                      option domain-name "cdac.in";
                      option domain-name-servers  10.10.10.2;
                      option interface-mtu 1500;
                      option domain-search  "cdac.in";
                      option cumulus-provision-url "http://192.168.20.131:80/install/postscripts/cumulusztp";
                      zone cdac.in. {
                         primary 10.10.10.2; key xcat_key; 
                      }
                      zone 20.168.192.IN-ADDR.ARPA. {
                         primary 10.10.10.2; key xcat_key; 
                      }
                      if option user-class-identifier = "xNBA" and option client-architecture = 00:00 { #x86, xCAT Network Boot Agent
                          always-broadcast on;
                          filename = "http://192.168.20.131:80/tftpboot/xcat/xnba/nets/192.168.20.0_24";
                      } else if option user-class-identifier = "xNBA" and option client-architecture = 00:09 { #x86, xCAT Network Boot Agent
                          filename = "http://192.168.20.131:80/tftpboot/xcat/xnba/nets/192.168.20.0_24.uefi";
                      } else if option client-architecture = 00:00  { #x86
                          filename "xcat/xnba.kpxe";
                      } else if option vendor-class-identifier = "Etherboot-5.4"  { #x86
                          filename "xcat/xnba.kpxe";
                      } else if option client-architecture = 00:07 { #x86_64 uefi
                           filename "xcat/xnba.efi";
                      } else if option client-architecture = 00:09 { #x86_64 uefi alternative id
                           filename "xcat/xnba.efi";
                      } else if option client-architecture = 00:02 { #ia64
                           filename "elilo.efi";
                      } else if option client-architecture = 00:0e { #OPAL-v3
                           option conf-file = "http://192.168.20.131:80/tftpboot/pxelinux.cfg/p/192.168.20.0_24";
                      } else if substring (option vendor-class-identifier,0,11) = "onie_vendor" { #for onie on cumulus switch
                          option www-server = "http://192.168.20.131:80/install/onie/onie-installer";
                      } else if substring(filename,0,1) = null { #otherwise, provide yaboot if the client isn't specific
                           filename "/yaboot";
                      }
                    } # 192.168.20.0/255.255.255.0 subnet_end
                  } # ens33 nic_end
                  shared-network virbr0 {
                    subnet 192.168.122.0 netmask 255.255.255.0 {
                      authoritative;
                      max-lease-time 43200;
                      min-lease-time 43200;
                      default-lease-time 43200;
                      option routers  192.168.122.1;
                      next-server  192.168.122.1;
                      option log-servers 192.168.122.1;
                      option ntp-servers 192.168.122.1;
                      option domain-name "cdac.in";
                      option domain-name-servers  10.10.10.2;
                      option interface-mtu 1500;
                      option domain-search  "cdac.in";
                      option cumulus-provision-url "http://192.168.122.1:80/install/postscripts/cumulusztp";
                      zone cdac.in. {
                         primary 10.10.10.2; key xcat_key; 
                      }
                      zone 122.168.192.IN-ADDR.ARPA. {
                         primary 10.10.10.2; key xcat_key; 
                      }
                      if option user-class-identifier = "xNBA" and option client-architecture = 00:00 { #x86, xCAT Network Boot Agent
                          always-broadcast on;
                          filename = "http://192.168.122.1:80/tftpboot/xcat/xnba/nets/192.168.122.0_24";
                      } else if option user-class-identifier = "xNBA" and option client-architecture = 00:09 { #x86, xCAT Network Boot Agent
                          filename = "http://192.168.122.1:80/tftpboot/xcat/xnba/nets/192.168.122.0_24.uefi";
                      } else if option client-architecture = 00:00  { #x86
                          filename "xcat/xnba.kpxe";
                      } else if option vendor-class-identifier = "Etherboot-5.4"  { #x86
                          filename "xcat/xnba.kpxe";
                      } else if option client-architecture = 00:07 { #x86_64 uefi
                           filename "xcat/xnba.efi";
                      } else if option client-architecture = 00:09 { #x86_64 uefi alternative id
                           filename "xcat/xnba.efi";
                      } else if option client-architecture = 00:02 { #ia64
                           filename "elilo.efi";
                      } else if option client-architecture = 00:0e { #OPAL-v3
                           option conf-file = "http://192.168.122.1:80/tftpboot/pxelinux.cfg/p/192.168.122.0_24";
                      } else if substring (option vendor-class-identifier,0,11) = "onie_vendor" { #for onie on cumulus switch
                          option www-server = "http://192.168.122.1:80/install/onie/onie-installer";
                      } else if substring(filename,0,1) = null { #otherwise, provide yaboot if the client isn't specific
                           filename "/yaboot";
                      }
                    } # 192.168.122.0/255.255.255.0 subnet_end
                  } # virbr0 nic_end
                  #definition for host cn00 aka host cn00 can be found in the dhcpd.leases file (typically /var/lib/dhcpd/dhcpd.leases)
  
* [root@master compute]# vim /etc/hosts
  
* [root@master compute]# lsdef cn00
  
                  Object name: cn00
                      arch=x86_64
                      currstate=netboot centos7.9-x86_64-compute
                      groups=compute,all
                      ip=10.10.10.3
                      mac=00:0c:29:11:A6:49
                      netboot=xnba
                      os=centos7.9
                      postbootscripts=otherpkgs
                      postscripts=syslog,remoteshell,syncfiles
                      profile=compute
                      provmethod=centos7.9-x86_64-netboot-compute
  
* [root@master compute]#  vim /etc/dhcp/dhcpd.conf.xcatbak
  
* [root@master compute]# vim /install/custom/netboot/compute.synclist
  
* [root@master compute]# cat /etc/shadow
  
                  root:$6$dm/zCUTo1cmA0ny2$GywBVrXnBS6JgBeIrz9gXkmYca.XnHZ.SBvyuDihWcMlg0XUTEhwShUGhaAng8SdDKNikiaRh/9.o1KG54lNo/::0:99999:7:::
                  bin:*:18353:0:99999:7:::
                  daemon:*:18353:0:99999:7:::
                  adm:*:18353:0:99999:7:::
                  lp:*:18353:0:99999:7:::
                  sync:*:18353:0:99999:7:::
                  shutdown:*:18353:0:99999:7:::
                  halt:*:18353:0:99999:7:::
                  mail:*:18353:0:99999:7:::
                  operator:*:18353:0:99999:7:::
                  games:*:18353:0:99999:7:::
                  ftp:*:18353:0:99999:7:::
                  nobody:*:18353:0:99999:7:::
                  systemd-network:!!:19511::::::
                  dbus:!!:19511::::::
                  polkitd:!!:19511::::::
                  libstoragemgmt:!!:19511::::::
                  colord:!!:19511::::::
                  rpc:!!:19511:0:99999:7:::
                  saned:!!:19511::::::
                  gluster:!!:19511::::::
                  amandabackup:!!:19511::::::
                  saslauth:!!:19511::::::
                  abrt:!!:19511::::::
                  setroubleshoot:!!:19511::::::
                  rtkit:!!:19511::::::
                  pulse:!!:19511::::::
                  radvd:!!:19511::::::
                  chrony:!!:19511::::::
                  unbound:!!:19511::::::
                  qemu:!!:19511::::::
                  tss:!!:19511::::::
                  sssd:!!:19511::::::
                  usbmuxd:!!:19511::::::
                  geoclue:!!:19511::::::
                  ntp:!!:19511::::::
                  gdm:!!:19511::::::
                  rpcuser:!!:19511::::::
                  nfsnobody:!!:19511::::::
                  gnome-initial-setup:!!:19511::::::
                  sshd:!!:19511::::::
                  avahi:!!:19511::::::
                  postfix:!!:19511::::::
                  tcpdump:!!:19511::::::
                  master:$6$K8bvw4t/pP4ce7vo$Yb.jQnVgyVCRIVJMPcAt/osCdsyDOUR6hP.1L7aeWN5uzDO67mc5AAQ5HZy1K8cRvsVhbmFici8X7NE4uoYBF.::0:99999:7:::
                  named:!!:19511::::::
                  dhcpd:!!:19511::::::
                  apache:!!:19511::::::
                  conserver:!!:19511::::::
  

* [root@master compute]# ping 10.10.10.3
  
                  PING 10.10.10.3 (10.10.10.3) 56(84) bytes of data.
                  64 bytes from 10.10.10.3: icmp_seq=1 ttl=64 time=1.23 ms
                  64 bytes from 10.10.10.3: icmp_seq=2 ttl=64 time=0.901 ms
                  64 bytes from 10.10.10.3: icmp_seq=3 ttl=64 time=0.889 ms
                  64 bytes from 10.10.10.3: icmp_seq=4 ttl=64 time=0.929 ms
                  64 bytes from 10.10.10.3: icmp_seq=5 ttl=64 time=0.930 ms
                  ^C
                  --- 10.10.10.3 ping statistics ---
                  5 packets transmitted, 5 received, 0% packet loss, time 4012ms
                  rtt min/avg/max/mdev = 0.889/0.976/1.234/0.134 ms
  
* [root@master compute]# ssh root@test1
  
                  ssh: Could not resolve hostname test1: Name or service not known
                  [root@master compute]# cat /etc/hosts
                  127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
                  ::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
                  10.10.10.2 master master.cdac.in
                  
                  10.10.10.3 cn00 cn00.cdac.in
  
* [root@master compute]# ssh root@cn00
  
                  Warning: Permanently added 'cn00,10.10.10.3' (ECDSA) to the list of known hosts.
                  
                  
                  Last failed login: Mon Jun  5 07:29:14 EDT 2023 on tty1
                  There was 1 failed login attempt since the last successful login.

* [root@cn00 ~]# passwd
  
                  -bash: passwd: command not found
  
* [root@cn00 ~]# passwd root
  
                  -bash: passwd: command not found
  
* [root@cn00 ~]# sudo passwd root
  
                  -bash: sudo: command not found
  
* [root@cn00 ~]# passwd
  
                  -bash: passwd: command not found
  
* [root@cn00 ~]# cat /etc/shadow
  
                  root:cluster:13880:0:99999:7:::
                  bin:*:18353:0:99999:7:::
                  daemon:*:18353:0:99999:7:::
                  adm:*:18353:0:99999:7:::
                  lp:*:18353:0:99999:7:::
                  sync:*:18353:0:99999:7:::
                  shutdown:*:18353:0:99999:7:::
                  halt:*:18353:0:99999:7:::
                  mail:*:18353:0:99999:7:::
                  operator:*:18353:0:99999:7:::
                  games:*:18353:0:99999:7:::
                  ftp:*:18353:0:99999:7:::
                  nobody:*:18353:0:99999:7:::
                  systemd-network:!!:19511::::::
                  dbus:!!:19511::::::
                  ntp:!!:19511::::::
                  rpc:!!:19511:0:99999:7:::
                  rpcuser:!!:19511::::::
                  nfsnobody:!!:19511::::::
                  sshd:!!:19511::::::
                  [root@cn00 ~]# hostname
                  cn00.cdac.in
                  [root@cn00 ~]# adduser cn00
                  [root@cn00 ~]# passwd cn00
                  -bash: passwd: command not found
                  [root@cn00 ~]# lsdef -t osimage centos7.9-x86_64-netboot-compute
                  -bash: lsdef: command not found
  
* [root@cn00 ~]# exit
  
                  logout
                  Connection to cn00 closed.
  
* [root@master compute]# lsdef -t osimage centos7.9-x86_64-netboot-compute
  
                  Object name: centos7.9-x86_64-netboot-compute
                      exlist=/opt/xcat/share/xcat/netboot/centos/compute.centos7.exlist
                      imagetype=linux
                      osarch=x86_64
                      osdistroname=centos7.9-x86_64
                      osname=Linux
                      osvers=centos7.9
                      otherpkgdir=/install/post/otherpkgs/centos7.9/x86_64
                      permission=755
                      pkgdir=/install/centos7.9/x86_64
                      pkglist=/opt/xcat/share/xcat/netboot/centos/compute.centos7.pkglist
                      postinstall=/opt/xcat/share/xcat/netboot/centos/compute.centos7.postinstall
                      profile=compute
                      provmethod=netboot
                      rootimgdir=/install/netboot/centos7.9/x86_64/compute
                      synclists=/install/custom/netboot/compute.synclist
  
* [root@master compute]# systemctl status sshd
  
                  ● sshd.service - OpenSSH server daemon
                     Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled; vendor preset: enabled)
                     Active: active (running) since Sat 2023-06-03 11:19:03 EDT; 1 day 14h ago
                       Docs: man:sshd(8)
                             man:sshd_config(5)
                   Main PID: 1389 (sshd)
                      Tasks: 1
                     CGroup: /system.slice/sshd.service
                             └─1389 /usr/sbin/sshd -D
                  
                  Jun 03 11:19:03 localhost.localdomain systemd[1]: Starting OpenSSH server daemon...
                  Jun 03 11:19:03 localhost.localdomain sshd[1389]: Server listening on 0.0.0.0 port 22.
                  Jun 03 11:19:03 localhost.localdomain sshd[1389]: Server listening on :: port 22.
                  Jun 03 11:19:03 localhost.localdomain systemd[1]: Started OpenSSH server daemon.
  
* [root@master compute]# systemctl restart sshd
  
* [root@master compute]# ssh root@cn00


                  Last failed login: Mon Jun  5 07:39:04 EDT 2023 on tty1
                  There was 1 failed login attempt since the last successful login.


* [root@cn00 ~]# exit 
                  logout
                  Connection to cn00 closed.

* [root@master compute]# lsdef -t osimage
  
                  centos7.9-x86_64-install-compute  (osimage)
                  centos7.9-x86_64-netboot-compute  (osimage)
                  centos7.9-x86_64-statelite-compute  (osimage)
  
* [root@master compute]# packimage centos7.9-x86_64-netboot-compute
  
                  Packing contents of /install/netboot/centos7.9/x86_64/compute/rootimg
                  archive method:cpio
                  compress method:gzip

* [root@master compute]# lsdef -i osimage centos7.9-x86_64-netboot-compute
  
                  Error: [master]: 'osimage' is not a valid attribute name for an object type of 'node'.
                  Error: [master]: Could not find an object named 'centos7.9-x86_64-netboot-compute' of type 'node'.
                  No object definitions have been found
  
* [root@master compute]# lsdef -t osimage centos7.9-x86_64-netboot-compute
  
                  Object name: centos7.9-x86_64-netboot-compute
                      exlist=/opt/xcat/share/xcat/netboot/centos/compute.centos7.exlist
                      imagetype=linux
                      osarch=x86_64
                      osdistroname=centos7.9-x86_64
                      osname=Linux
                      osvers=centos7.9
                      otherpkgdir=/install/post/otherpkgs/centos7.9/x86_64
                      permission=755
                      pkgdir=/install/centos7.9/x86_64
                      pkglist=/opt/xcat/share/xcat/netboot/centos/compute.centos7.pkglist
                      postinstall=/opt/xcat/share/xcat/netboot/centos/compute.centos7.postinstall
                      profile=compute
                      provmethod=netboot
                      rootimgdir=/install/netboot/centos7.9/x86_64/compute
                      synclists=/install/custom/netboot/compute.synclist
  
* [root@master compute]# cat /install/custom/netboot/compute.synclist
  
                  cat: /install/custom/netboot/compute.synclist: No such file or directory
  
* [root@master compute]# vim /install/custom/netboot/compute.synclist
* [root@master compute]# vim /install/custom/netboot/compute.synclist
* [root@master compute]# cat /install/custom/netboot/compute.synclist
  
                  /etc/passwd -> /etc/passwd
                  /etc/shadow -> /etc/shadow
                  /etc/group -> /etc/group
  
* [root@master compute]# lsdef -t osimage centos7.9-x86_64-netboot-compute
  
                  Object name: centos7.9-x86_64-netboot-compute
                      exlist=/opt/xcat/share/xcat/netboot/centos/compute.centos7.exlist
                      imagetype=linux
                      osarch=x86_64
                      osdistroname=centos7.9-x86_64
                      osname=Linux
                      osvers=centos7.9
                      otherpkgdir=/install/post/otherpkgs/centos7.9/x86_64
                      permission=755
                      pkgdir=/install/centos7.9/x86_64
                      pkglist=/opt/xcat/share/xcat/netboot/centos/compute.centos7.pkglist
                      postinstall=/opt/xcat/share/xcat/netboot/centos/compute.centos7.postinstall
                      profile=compute
                      provmethod=netboot
                      rootimgdir=/install/netboot/centos7.9/x86_64/compute
                      synclists=/install/custom/netboot/compute.synclist
  
* [root@master compute]# nodeset compute osimage=centos7.9-x86_64-netboot-compute
  
                  cn00: netboot centos7.9-x86_64-compute
  
* [root@master compute]# packimage centos7.9-x86_64-netboot-compute
  
                  Packing contents of /install/netboot/centos7.9/x86_64/compute/rootimg
                  archive method:cpio
                  compress method:gzip

* [root@master compute]# makenetworks
  
                  Warning: [master]: The network entry '10_10_10_0-255_255_255_0' already exists in xCAT networks table. Cannot create a definition for '10_10_10_0-255_255_255_0'
                  Warning: [master]: The network entry '192_168_20_0-255_255_255_0' already exists in xCAT networks table. Cannot create a definition for '192_168_20_0-255_255_255_0'

* [root@master compute]#  makedns -n
  
                           Warning: SELINUX is not disabled. The makedns command will not be able to generate a complete DNS setup. Disable SELINUX and run the command again.
                           Handling master in /etc/hosts.
                           Handling localhost in /etc/hosts.
                           Handling localhost in /etc/hosts.
                           Handling cn00 in /etc/hosts.
                           Getting reverse zones, this may take several minutes for a large cluster.
                           Completed getting reverse zones.
                           Updating zones.
                           Completed updating zones.
                           Restarting named
                           Restarting named complete
                           Updating DNS records, this may take several minutes for a large cluster.
                           Error: [master]: No reply received when sending DNS update to zone 10.10.10.IN-ADDR.ARPA.

* [root@master compute]# sestatus
  
                  SELinux status:                 enabled
                  SELinuxfs mount:                /sys/fs/selinux
                  SELinux root directory:         /etc/selinux
                  Loaded policy name:             targeted
                  Current mode:                   permissive
                  Mode from config file:          disabled
                  Policy MLS status:              enabled
                  Policy deny_unknown status:     allowed
                  Max kernel policy version:      31
  
* [root@master compute]# vim /etc/selinux/config
* [root@master compute]# setenforce 0
* [root@master compute]# getenforce 

                   Permissive

* [root@master compute]#  makedns -n
  
                  Warning: SELINUX is not disabled. The makedns command will not be able to generate a complete DNS setup. Disable SELINUX and run the command again.
                  Handling master in /etc/hosts.
                  Handling localhost in /etc/hosts.
                  Handling localhost in /etc/hosts.
                  Handling cn00 in /etc/hosts.
                  Getting reverse zones, this may take several minutes for a large cluster.
                  Completed getting reverse zones.
                  Updating zones.
                  Completed updating zones.
                  Restarting named
                  Restarting named complete
                  Updating DNS records, this may take several minutes for a large cluster.
                  Error: [master]: No reply received when sending DNS update to zone 10.10.10.IN-ADDR.ARPA.
                  Error: [master]: No reply received when sending DNS update to zone cdac.in.
                  Completed updating DNS records.
                  DNS setup is completed














