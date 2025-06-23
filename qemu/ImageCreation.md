# QEMU Image Creation

The following instructions describe how to create the ICFP 2024 AEC base VM
image. If you want to create your own VM image (e.g. with more disk space),
please stick to these instructions where possible so that the reviewers
experience as few surprises as possible.

Note that not all steps are reproducible, so even if you follow these
instructions exactly, your image may not be byte-for-byte identical with the
image we provide.

## Download Debian Installation Image

From https://debian.org download `debian-12.11.0-amd64-netinst.iso`.

## Create Disk Images

Create a disk image using QEMU's native Copy On Write (QCOW) sparse format.
The logical size of the image is 16G but it will only allocate physical space
from the host as needed.

```
$ qemu-img create -f qcow2 disk.qcow 16G
```

Start up the guest.

```
$ qemu-system-x86_64 -hda disk.qcow -cdrom debian-12.11.0-amd64-netinst.iso -boot d -m 4096 -accel <acceleration method>
```

The purpose of the flags is:

- `-hda disk.qcow` uses the created disk image as the first hard disk.
- `-cdrom debian-12.11.0-amd64-netinst.iso` uses the Debian installation
  cdrom image.
- `-boot d` makes it boot from the cdrom image.
- `-m 4096` starts with 4GB of RAM.
- `-accel <acceleration method>` selects a hardware acceleration method. See
  the included `start.sh` script to find out which acceleration method is
  appropriate for your operating system. You can also omit this option, but
  then the installation process will be much slower.

## Install Debian

Follow the installation instructions. The installation requires an internet
connection. We made the following choices during the installation process:

* Language: English
* Location: United States
* Keymap: American English
* Hostname: artifact
* Domain name: none
* Root password: password
* Non-root user: artifact
* Non-root user username: artifact
* Non-root user password: password
* Time zone: Central
* Use manual partitioning to create a new partition table with one partition.
  Use all available disk space for this partition, format it as ext4 and set
  its `bootable` flag to `on`. Do not create a swap partition.
* Wait for Debian to install the base system packages.
* Do not scan for additional installation media.
* Use `deb.debian.org` in the United States as the Debian archive mirror.
* Do not use HTTP proxying.
* Wait for Debian to install additional software.
* Disable automatic updates.
* Disable `popularity-contest` telemetry.
* Select the following software to install:
  * SSH server
  * standard system utilities
* Install GRUB to `/dev/sda`.
* Let the system reboot. Shut down QEMU as soon as the system has rebooted.

## Setup Debian

Start the VM again, this time without the installation cdrom image.

```
$ qemu-system-x86_64 -hda disk.qcow -m 4096 -accel <acceleration method>
```

Login to the VM as user `root` (password `password`).

Install some standard packages.

```
$ apt install sudo ssh git
```

Give the non-root user `sudo` privileges.

```
$ usermod -aG sudo artifact
```

Remove the history. If you accessed any of your own private servers when
testing the image, then you don't want these showing up in the history.
As history is saved on log out, log out first, then log in again remove the history.

```
$ rm .bash_history
```

Shutdown the image.

```
$ shutdown now
```
