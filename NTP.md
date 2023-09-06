                        systemctl stop firewalld
                        systemctl disable firewalld
                        vim /etc/Selinux/config'
                              enforcing = disabled
                         Do above step on both machine
                         +++++++++++++++++++++++++++++++++++
                         
                         Machine 1
                         
                         vim /etc/ntp.conf
                         edit with
                         restrict 192.168.20.0 255.255.255.0
                         .
                         .
                         .
                         .
                         comment all server 0, 1, 2, 3
                         restrit 192.168.1.0 mask 255.255.255.0
                         :wq
                         
                         ============================================
                         Machine 2
                         
                         edit only one server and all are comment
                         server 192.168.20.1.0 hpc-1
                         :wq 
                         
                         
                         systemctl status ntp
                         systemctl start ntp
                         systemctl restart ntp
                         
                         ntpq -p 
                         
