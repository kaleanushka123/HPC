                      yum install nfs-utils
                      rpm -qa | grep nfs
                      df -Th
                      ls /run/media/root/CentOS/7/x86_64/
                      
                      vim /etc/exports
                      mkdir/
                      mkdir/home2
                      vim /etc/exports
                      /gome2 *(re.sync no_root_squash)
                      :wq
                      
                      exports -a
                      
                      systemctl start nfs-server.service
                      systemctl status nfs-server.service
                      
                      showmount -e
                      
                      ++++++++++++++++++++++++++++++++++++++++++++++++++++++
                      
                      On Machine 2
                      
                      rpm -qa | grep nfs
                      systemctl status nfs
                      systemctl start nfs
                      
                      shomount -e
                      showmount -e 192.168.20.174
                      df -Th
                      mkdir /home2
                      ping hpc-1
                      ls /home2/
                      showmount -e hpc-1
                      mount -t nfs hpc-1:/home2/home2
