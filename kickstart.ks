# accept the EULA, prevent it from stopping the install
vmaccepteula
 
# set the root password
rootpw Shad0w33!
 
# use the first disk, always overwrite
autopart --firstdisk=local --overwritevmfs
 
# install from local media
install --firstdisk --overwritevmfs
 
# basic networking
network --bootproto=static --device=vmnic2 --ip=10.36.8.26 --netmask=255.255.255.0 --gateway=10.36.8.1 --hostname=gb5-az01-esx-06.io.thehut.local --vlanid=2409 --nameserver=10.36.12.101
 
# reboot at the end
reboot

%firstboot --interpreter=busybox

#Enable and start SSH
vim-cmd hostsvc/enable_ssh
vim-cmd hostsvc/start_ssh

#Enable and start ESXi Shell
vim-cmd hostsvc/enable_esx_shell
vim-cmd hostsvc/start_esx_shell

#Suppress DCUI warnings of ESXi Shell and SSH being enabled
esxcli system settings advanced set -o /UserVars/SuppressShellWarning -i 1
esxcli system hostname set --fqdn=gb5-az01-esx-06

#Set and Enable NTP
echo "server 10.11.127.252" >> /etc/ntp.conf;
/sbin/chkconfig ntpd on