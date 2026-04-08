Bios setup first

1. Enable WoL on Lan with PXE, For some reason the LAN only doesn't work even though the NIC is turned on
2. Make sure that Deep Sleep Control is Disabled. This what's makes the onboard NIC to be turned on and ofcourse to receive the mmagic packet
3. Enable Legacy Option ROMs should be disabled
4. UEFI Boot Path Security set on Never
5. UEFI Network Stack should be enabled

Now on the Ubuntu side

1. Check the net interface with
```bash
ip link show
```
2. Find enp1s0. (This one worked for me but base on my research it can be eth0  or enp3s0 or any number like mine its enp1s0) and then get the mac address we will need that later
3. Now check if WoL is turned on just to be safe
```bash
sudo ethtool eth0 | grep Wake

# This what it should looke like if its on
~ Supports Wake-on: pumbg
~ Wake-on: g
```
4. If not let's enable it.
```bash
# Check first what .yaml you have. When I did it I only have one so i default on that
ls -la /etc/netplan # or add sudo if needs permission wtf i dont remember

# In my case its 50-cloud-init.yaml
sudo nano /etc/netplan/50-cloud-init.yaml

# Add this "wakeonlan: true"

# now apply it
sudo netplan apply
```
5. So now to check it just to be sure
```bash
sudo cat /etc/netplan/50-cloud-init.yaml
```
```yaml
network:
  version: 2
  ethernets:
    enp1s0:
      dhcp4: true
      wakeonlan: true
```
and then the other command earlier
```bash
sudo ethtool eth0 | grep Wake
```

So now were done. just shut it down and this your options

1. Windows. grab the script.ps1 that we have in this repo and run it as administrator in powershell
2. Linux just install wakeonlan then enter wakeonlan "mac-address". Like this
```bash
sudo apt install wakeonlan
wakeonlan A1:B1:C2:D1:E1:F4
```

That's it.
