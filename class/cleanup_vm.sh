#!/usr/bin/env bash
#VBoxManage list runningvms | awk '{print $2}'| tr -d '{'| tr -d '}'
for vm in $(VBoxManage list vms | awk '{print $2}'| tr -d '{'| tr -d '}'); do
  #statements
  printf "Cleaning up VM %s.\n" "$vm"
  VBoxManage controlvm "$vm" poweroff
  VBoxManage discardstate "$vm"
  VBoxManage unregistervm --delete "$vm"
done
for interface in $(vboxmanage list hostonlyifs|awk '/^Name/ {print $2}'); do
        printf "Cleaning up host only interface %s.\n" "$interface"
        vboxmanage hostonlyif remove "$interface"
done
for dhcpserver in $(vboxmanage list dhcpservers|awk '/^NetworkName/ {print $2}'); do
        printf "Cleaning up dhcp server %s.\n" "$dhcpserver"
        vboxmanage dhcpserver remove --netname "$dhcpserver"
done
printf "Done.\n"
exit 0
