          Centos operating system
          MAchine 1
          su -
          useradd hpcsa
          passwd hpcsa
          ssh--keygen
          ssh-copy-id hpcsa@192.168.20.175
          ssh hpcsa@192.168.20.175
          +++++++++++++++++++++++++++++++++++++===
          Same For Another Machine
          ++++++++++++++++++++++++++++++++++++++++
          
          hostname set-hostname hpc-1  hpc-2
          
          rm -rf .ssh
          ssh-keygen
          ls -al
          ls -al .ssh/
          cat .ssh/id-rsa.pub
          copy generated key
          
          ++++++++++
          
          
          ON Another Machine
          ++++++++++++=====
          rm -rf .ssh
          ssh-keygen
          ls -al
          ls -al .ssh/
          cd .ssh/
          vim authorized-keys
          copy generated key from machine 1

