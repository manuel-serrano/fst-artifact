# Float Self Tagging Artifact

Name: Float Self-Tagging

  * URL: https://zenodo.org/records/XXX
  * GITHUB: git@github.com:omelancon/fst-artifact

## Artifact Instructions

This artifact can be installed and ran either:

  1. using the VM available at https://zenodo.org/records/XXXX
  2. using the a native installation. 
  
The VM provides a complete Linux image where a native version
of the artifact has been pre-installed. 

### Alternative 1: VM-base artifact

To execute the artifact via the VM distribution, install QEMU and run
the virtual machine as instructed in Section [QEMU Instructions] (see
below). Once connected to the VM go into the `sft-artifact`
directory. It contains a pre-installed native version of
the artifact (as documented in Section [Native Artifact]). To execute it:

```shell
./script/run.sh
```

This generates PDF figures located into the directory XXXX

### Alternative 2: Native artifact


In order to install the version of the FST artifact a full development
kit is required. It must contain:

  - a full-fledged C compiler
  - a full-fledged make tool
  - a posix shell

Under Linux Debian or Ubuntu the requirements can be installed with:

```
apt update
sudo apt dist-upgrade
sudo apt install -y libgmp-dev libgmp10 autoconf automake libtool libunistring-dev gnuplot
```


## Artifact Instructions

```
(qemu) ROOT=$HOME/flt ./scripts/run.sh
```



## QEMU Instructions

The Float Self-Tagging is using a Debian QEMU image as a base for
artifacts. QEMU is a hosted virtual machine monitor that can emulate a
host processor via dynamic binary translation. On common host
platforms QEMU can also use a host provided virtualization layer,
which is faster than dynamic binary translation.

QEMU homepage: https://www.qemu.org/

### Installation

#### OSX
``brew install qemu``

#### Debian and Ubuntu Linux
``apt-get install qemu-kvm``

On x86 laptops and server machines you may need to enable the
"Intel Virtualization Technology" setting in your BIOS, as some manufacturers
leave this disabled by default. See Debugging.md for details.


#### Arch Linux

``pacman -Sy qemu``

See the [Arch wiki](https://wiki.archlinux.org/title/QEMU) for more info.

See Debugging.md if you have problems logging into the artifact via SSH.


#### Windows 10

Download and install QEMU via the links at

https://www.qemu.org/download/#windows.

Ensure that `qemu-system-x86_64.exe` is in your path.

Start Bar -> Search -> "Windows Features"
          -> enable "Hyper-V" and "Windows Hypervisor Platform".

Restart your computer.

#### Windows 8

See Debugging.md for Windows 8 install instructions.

### Startup

The base artifact provides a `start.sh` script to start the VM on unix-like
systems and `start.bat` for Windows. Running this script will open a graphical
console on the host machine, and create a virtualized network interface.
On Linux you may need to run with `sudo` to start the VM. If the VM does not
start then check `Debugging.md`

Once the VM has started you can login to the guest system from the host.
Whenever you are asked for a password, the answer is `password`. The default
username is `artifact`.

```
$ ssh -p 5555 artifact@localhost
```

You can also copy files to and from the host using scp.

```
$ scp -P 5555 artifact@localhost:somefile .
```

### Shutdown

To shutdown the guest system cleanly, login to it via ssh and use

```
(qemu) sudo shutdown now
```

### Artifact Preparation

This section described how a bare Debian VM should be prepared before
running the experiment.

Inside the bare Debian VM run the following commands:

```
(qemu) sudo apt update
(qemu) sudo apt dist-upgrade
(qemu) sudo apt install -y libgmp-dev libgmp10 autoconf automake libtool libunistring-dev gnuplot
(qemu) ROOT=$HOME/flt ./scripts/install.sh
```


