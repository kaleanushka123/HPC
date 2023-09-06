# -----------FOR NFS------------------

# ON MASTER:
* iptables -F
* systemctl stop firewalld.service 
* systemctl disable firewalld.service 
* systemctl status firewalld.service 
* vi /etc/selinux/config 
* hostnamectl set-hostname server
* exec bash
* init 6
* ip a
* yum update -y
* yum install -y nfs-utils
* systemctl start nfs-server rpcbind
* systemctl enable nfs-server rpcbind
 
* mkdir home/
* chmod 777 /home/
* vi /etc/exports
	/home *(rw,sync,no_root_squash)

* exportfs -r
* ls /home
         test
* unmount ..

# ---------FOR SLURM------------
* yum install epel-release -y
* yum install munge munge-libs munge-devel -y
* ll /etc/munge  
 
* create-munge-key -r
* scp /etc/munge/munge.key client1:/etc/munge/
* scp /etc/munge/munge.key client2:/etc/munge/
* systemctl restart munge.service 
* systemctl status munge.service
* chown munge:munge /etc/munge/ 
* wget https://download.schedmd.com/slurm/slurm-20.11.9.tar.bz2
* yum install rpm-build
* rpmbuild -ta slurm-20.11.9.tar.bz2 
* yum install python3 readline-devel perl-ExtUtils-MakeMaker -y
* yum install python3 readline-devel perl-ExtUtils-MakeMaker mysql-devel -y
* yum install gcc -y
* rpmbuild -ta slurm-20.11.9.tar.bz2 
* yum install pam-devel 
* rpmbuild -ta slurm-20.11.9.tar.bz2 
* ls /root/rpmbuild/RPMS/x86_64/
* mkdir /home/rpms
* cd /root/rpmbuild/RPMS/x86_64/
* cp * /home/rpms/
* ls
* cd
* cd /home/rpms/
* ls
* yum --nogpgcheck localinstall * -y
* pwd
* cd ..
* ls
* scp rpms client1:/root
* scp -r rpms client1:/root
* scp -r rpms client2:/root
* rpm -qa | grep slurm | wc -l
* export SLURMUSER=900
* groupadd -g $SLURMUSER slurm
* useradd -m -c "SLURM workload manager" -d /var/lib/slurm -u $SLURMUSER -g slurm -s /bin/bash slurm
* cd
* mkdir /var/spool/slurm
* ll /var/spool/slurm
* chown slurm:slurm /var/spool/slurm
* ll /var/spool/
* mkdir /var/log/slurm
* chown -R slurm . /var/log/slurm
* touch /var/log/slurm/slurmctld.log
* chown slurm:slurm /var/log/slurm/slurmctld.log
* touch /var/log/slurm/slurm_jobacct.log /var/log/slurm_jobcomp.log
* chown slurm: /var/log/slurm/slurm_jobacct.log /var/log/slurm_jobcomp.log
* cp /etc/slurm/slurm.conf.example /etc/slurm/slurm.conf
* vi etc/slurm/slurm.conf
* vi /etc/slurm/slurm.conf
*		       ClusterName=HPCSA
		       ControlMachine=server
		       #ControlAddr=
		       #BackupController=
		       #BackupAddr=
		         +++++
		       # COMPUTE NODES
		       NodeName=linux[1-32] Procs=1 State=UNKNOWN
		       NodeName=client1 CPUs=2 Boards=1 SocketsPerBoard=2 CoresPerSocket=1 ThreadsPerCore=1 RealMemory=3770 State=UNKNOWN
		       NodeName=client2 CPUs=2 Boards=1 SocketsPerBoard=2 CoresPerSocket=1 ThreadsPerCore=1 RealMemory=3770 State=UNKNOWN
		       PartitionName=standard Nodes=ALL Default=YES MaxTime=INFINITE State=UP

* scp /etc/slurm/slurm.conf client1:/etc/slurm/
* scp /etc/slurm/slurm.conf client2:/etc/slurm/
* systemctl restart slurmctld.service 
* systemctl enable slurmctld.service 

# ---------------------FOR NFS------------------

# ON CLIENT1 and CLIENT2:
* hostnamectl set-hostname client1
* exec bash
* yum update -y
* kill -9 10069
* vi /etc/selinux/config 
* systemctl stop firewalld.service
* systemctl disable firewalld.service
* systemctl status firewalld.service
* init 6
* yum install -y nfs-utils
  
* showmount -e 192.168.20.186 {SERVER NAT IP}
* mkdir /mnt/home
* mount 192.168.20.186:/home /mnt/home
* mount | grep nfs
* df -hT
* touch /mnt/home/test
* ls /mnt/home
         	test
* vi /etc/fstab
        	192.168.1.10:/home /mnt/home    nfs     nosuid,rw,sync,hard,intr  0  0
* reboot
* df -hT
* mount | grep nfs
* unmount (optional command) 

# -------FOR SLURM---------------------

* yum install munge munge-libs munge-devel -y
* cd /etc/munge
* ls
* systemctl restart munge.service
* chown munge:munge /etc/munge/munge.key 
* systemctl restart munge.service
* yum install pam-devel python3 readline-devel perl-ExtUtils-MakeMaker mysql-devel -y
* export SLURMUSER=900
* groupadd -g $SLURMUSER slurm
* useradd -m -c "SLURM workload manager" -d /var/lib/slurm -u $SLURMUSER -g slurm -s /bin/bash slurm
* cd /home/rpms
* mkdir /home/rpms
* cd /home/rpms/
* ll
* dh -Th
* ls /mnt/home
* ll
* mount | grep nfs
* df -Th
* cd
* ll /root
* cd rpms
* ll
* rm -rf slurm-slurmctld-20.11.9-1.el7.x86_64.rpm 
* cd
   
* yum --nogpgcheck localinstall * -y
* rpm -qa | grep slurm | wc -l
* ls
* cd rpms
* ls
* yum install --nogpgcheck localinstall * -y
* rpm -qa | grep slurm | wc -l
* rpm -e slurm-slurmdbd
* ls
* rpm -qa | grep slurm | wc -l
* mkdir /var/spool/slurm
* cd
* chown slurm:slurm /var/spool/slurm
* mkdir /var/log/slurm
* chown -R slurm . /var/log/slurm
* slurmd -C [TO SEE THE STATUS OF NODES]
* systemctl restart slurmd.service 
* systemctl enable slurmd.service


# =============DAY2=============

# ON MASTER:

* systemctl restart slurmctld.service
* systemctl status slurmctld.service
* sinfo
* systemctl restart munge.service
* systemctl statud munge.service
* systemctl status munge.service
* sinfo
* scontrol update node=client1 state=idle
* scontrol update node=client2 state=idle
			  [root@server ~]# sinfo
			PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
			standard*    up   infinite      2  idle client[1-2]
* slurmctld -Dvv  {TO CHECK THE LOG OR DEIUG}
* scp /etc/slurm/slurm.conf client:/etc/slurm/
* sinfo
* srun -w client --pty /bin/bash
* vim demo.sh
* sbatch demo.sh
* squeue
* sinfo
* squeue
* sinfo
* scontrol show job 3
* yum install mariadb-server mariadb-devel -y
* systemctl enable mariadb
* systemctl start mariadb
* systemctl status mariadb
* mysql
* mysql -p -u slurm
* cd /etc/my.cnf.d/
* ll
* vim innodb.cnf
* cd
* systemctl stop mariadb
* ll /var/lib/
* ll /var/lib/mysql/
* mv /var/lib/mysql/ib_logfile0 /tmp/
* systemctl start mariadb
* journalctl -xe
* vi /etc/my.cnf
* yum autoremove mariadb*
* yum reinstall mariadb*
* systemctl restart mariadb
* systemctl status mariadb
* cd /var/lib/
* ll
* cd m
* cd mysql/
* ll
* mkdir back
* mv aria_log* ibdata1 ib_logfile* back/
* ls
* systemctl restart mariadb
* systemctl status mariadb
* systemctl enable mariadb
* sacct
* systemctl status slurmdbd
* cd 
* mysql
* ll /etc/slurm/
* vim /etc/slurm/slurmdbd.conf
* chown slurm: /etc/slurm/slurmdbd.conf
* chmod 600 /etc/slurm/slurmdbd.conf
* touch /var/log/slurmdbd.log
* chown slurm: /var/log/slurmdbd.log
* slurmdbd -D -vvv
	systemctl enable slurmdbd
	systemctl start slurmdbd
	systemctl status slurmdbd
	systemctl enable slurmctld.service
	systemctl start slurmctld.service
	systemctl status slurmctld.service

# ON CLIENT1 & CLIENT2:

* systemctl restart munge.service
* systemctl status munge.service
* sinfo
* hostname
* systemctl restart slurmd.service
* systemctl status slurmd.service
* slurmd -Dvv  {TO CHECK THE LOG OR DEIUG}
  




















































   
   
