	DO SOME BASICS COMMANDS
* cd /home
* create directory
* copy user in that directory
* cp -R /etc/passwd /testdir

===================================================================================================================================
# MASTER MACHINE

* yum install openldap-servers openldap-clients
* cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG (database file located in (var /lib/ldap/DB_CONFIG))
* chown ldap. /var/lib/ldap/DB_CONFIG (it sets permission root to ldap)
* ll /var/lib/ldap/ (check if permission is set with ldap or not)
* systemctl start slapd
* systemctl enable slapd
* slappasswd (set password)
  
				------encrypted password is generated
				{SSHA}dvAIVLEV+ZPxs6hw3gnfPf2kpy8WB+qj

  * vim chrootpw.ldif
    
					dn: olcDatabase={0}config,cn=config
					    changetype:modify
					    add: olcRootPW
					    olcRootPW: {SSHA}dvAIVLEV+ZPxs6hw3gnfPf2kpy8WB+qj
						ldap password set kiya isliye humne database me password save karte hai
						kuch bhi authentication dene l keliye humne ldap password set kiya hai to yahi password dena padega


* ldapadd -Y EXTERNAL -H ldapi:/// -f chrootpw.ldif
  
						SASL/EXTERNAL authentication started
						   SASL username: gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth
						   SASL SSF: 0
						   modifying entry "olcDatabase={0}config,cn=config"
				
						Simple Authentication and Security Layer (SASL)
						ldap ka authentication secure hona chahiye isliye hum SASL add karrhe hai

* -H -HOST
* -Y exernal protocol 

* ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif
* ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif 
* ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif
  
					------we add schema in ldap which is already define
					---and we only add those schema which is define in ldap
* vim chdomain.ldif

					dn: olcDatabase={1}monitor,cn=config
					changetype: modify
					replace: olcAccess
					olcAccess: {0}to * by dn.base="gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth"
					  read by dn.base="cn=Manager,dc=cdac,dc=in" read by * none
					
					
					dn: olcDatabase={2}hdb,cn=config
					changetype: modify
					replace: olcSuffix
					olcSuffix: dc=cdac,dc=in
					
					dn: olcDatabase={2}hdb,cn=config
					changetype: modify
					replace: olcRootDN
					olcRootDN: cn=Manager,dc=cdac,dc=in
					
					dn: olcDatabase={2}hdb,cn=config
					changetype: modify
					add: olcRootPW
					olcRootPW: {SSHA}dvAIVLEV+ZPxs6hw3gnfPf2kpy8WB+qj
					
					dn: olcDatabase={2}hdb,cn=config
					changetype: modify
					add: olcAccess
					olcAccess: {0}to attrs=userPassword,shadowLastChange by
					  dn="cn=Manager,dc=cdac,dc=in" write by anonymous auth by self write by * none
					olcAccess: {1}to dn.base="" by * read
					olcAccess: {2}to * by dn="cn=Manager,dc=cdac,dc=in" write by * read


* ldapmodify -Y EXTERNAL -H ldapi:/// -f chdomain.ldif
* we get output like below
  
				SASL/EXTE6RNAL authentication started
				SASL username: gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth
				SASL SSF: 0
				modifying entry "olcDatabase={1}monitor,cn=config"
				
				modifying entry "olcDatabase={2}hdb,cn=config"
				
				modifying entry "olcDatabase={2}hdb,cn=config"
				
				modifying entry "olcDatabase={2}hdb,cn=config"
				
				modifying entry "olcDatabase={2}hdb,cn=config"

* vim basedomain.ldif
  
					dn: dc=cdac,dc=in
					objectClass: top
					objectClass: dcObject
					objectclass: organization
					o: cdac in
					dc: cdac
					
					dn: cn=Manager,dc=cdac,dc=in
					objectClass: organizationalRole
					cn: Manager
					description: Directory Manager
					
					dn: ou=People,dc=cdac,dc=in
					objectClass: organizationalUnit
					ou: People
					
					dn: ou=Group,dc=cdac,dc=in
					objectClass: organizationalUnit
					ou: Group
					          
					16) ldapadd -x -D cn=Manager,dc=cdac,dc=in -W -f basedomain.ldif  
					--
					Enter LDAP Password: 
					adding new entry "dc=cdac,dc=in"
					
					adding new entry "cn=Manager,dc=cdac,dc=in"
					
					adding new entry "ou=People,dc=cdac,dc=in"
					
					adding new entry "ou=Group,dc=cdac,dc=in"

* vim ldapuser.ldif
  
					dn: uid=user1,ou=People,dc=cdac,dc=in
					objectClass: inetOrgPerson
					objectClass: posixAccount
					objectClass: shadowAccount
					cn: user1
					sn: test
					userPassword: {SSHA}dvAIVLEV+ZPxs6hw3gnfPf2kpy8WB+qj
					loginShell: /bin/bash
					uidNumber: 1001
					gidNumber: 1001
					homeDirectory: /home/user1
					
					dn: cn=user1,ou=Group,dc=cdac,dc=in
					objectClass: posixGroup
					cn: user1
					gidNumber: 1001
			

* ldapadd -x -D cn=Manager,dc=cdac,dc=in -W -f ldapuser.ldif
  
					--Enter LDAP Password: 
					adding new entry "uid=user1,ou=People,dc=cdac,dc=in"
					
					adding new entry "cn=user1,ou=Group,dc=cdac,dc=in"


* ldapsearch -x cn=user1 -b dc=cdac,dc=in

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


# ON CLIENT MACHINE

* yum install openldap-clients nss-pam-ldapd
* authconfig --enableldap --enableldapauth --ldapserver=192.168.20.135 --ldapbasedn="dc=cdac,dc=in" --enablemkhomedir --update
* systemctl status nslcd
* systemctl start nslcd
* vim /etc/nsswitch.conf (if user is not visible the open this file edit ldap)
  
					passwd:     files sss ldap
			               shadow:     files sss ldap
			               group:      files sss ldap


* If you get permission denied then
* vim /etc/pam.d/password-auth-ac
  

					#%PAM-1.0
					# This file is auto-generated.
					# User changes will be destroyed the next time authconfig is run.
					auth        required      pam_env.so
					auth        required      pam_faildelay.so delay=2000000
					auth        [default=1 ignore=ignore success=ok] pam_succeed_if.so uid >= 1000 quiet
					auth        [default=1 ignore=ignore success=ok] pam_localuser.so
					auth        sufficient    pam_unix.so nullok try_first_pass
					auth        requisite     pam_succeed_if.so uid >= 1000 quiet_success
					auth        sufficient    pam_sss.so forward_pass
					auth        sufficient    pam_ldap.so use_first_pass
					auth        required      pam_deny.so
					
					account     required      pam_unix.so broken_shadow
					account     sufficient    pam_localuser.so
					account     sufficient    pam_succeed_if.so uid < 1000 quiet
					account     [default=bad success=ok user_unknown=ignore] pam_sss.so
					account     required      pam_permit.so
					
					password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=
					password    sufficient    pam_unix.so sha512 shadow nullok try_first_pass use_authtok
					password    sufficient    pam_sss.so use_authtok
					password    sufficient    pam_ldap.so use_authtok
					password    required      pam_deny.so
					
					session     optional      pam_keyinit.so revoke
					session     required      pam_limits.so
					-session     optional      pam_systemd.so
					session     optional      pam_oddjob_mkhomedir.so umask=0077
					session     [success=1 default=ignore] pam_succeed_if.so service in crond quiet use_uid
					session     required      pam_unix.so
					session     optional      pam_ldap.so
					session     optional      pam_sss.so


* ssh user1@localhost
