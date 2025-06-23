OOPSLA 2025 Artifact
==================
![branch workflow](https://github.com/manuel-serrano/oopsla-2025-flt/actions/workflows/oopsla-2025-flt.yml/badge.svg)

Name: Float Self Tagging

  * DOI: XXXXXX10.5281/zenodo.11481893
  * URL: XXXXXXhttps://zenodo.org/records/11481893


```bibtex
@article{oopsla-2025
}
```

## Artifact Instructions

This artifact can be installed and ran either:

  1. using the VM available at XXXXhttps://zenodo.org/records/11481893;
  2. using the a native installation. 
  
The VM provides a complete Linux image where a native version
of the artifact has been pre-installed. 

### Alternative 1: VM-base artifact

To execute the artifact via the VM distribution, install QEMU and run
the virtual machine as instructed in Section [QEMU Instructions] (see
below). Once connected to the VM go into the `oopsla-2025`
directory. It contains a pre-installed native version of
the artifact (as documented in Section [Native arifact]). To execute it:

```shell
ROOT=$HOME/flt ./script/run.sh
```

### Alternative 2: Native artifact

In order to install the version of the OOPSLA artifact the following
packages are required:

  - `git`
  - `gnuplot`
  - `automake`
  - `autoconf`
  - `gcc`
  - `libtool`
  - `gmp`
  - `libunistring`
  - `make`

Then, to install the artifact from a Linux platform:

```
git clone https://github.com/manuel-serrano/oopsla-2025-flt.git
cd oopsla-2025-flt
```

To run it

```shell
ROOT=$HOME/flt ./script/install.sh
```

## The Artifact

Blabla, the figures in artifact/plot.XXX
  
  
## QEMU Instructions

The OOPSLA 2025 Artifact Evaluation Process is using a Debian QEMU image as a
base for artifacts. The Artifact Evaluation Committee (AEC) will verify that
this image works on their own machines before distributing it to authors.
Authors are encouraged to extend the provided image instead of creating their
own. If it is not practical for authors to use the provided image then please
contact the AEC co-chairs before submission.

QEMU is a hosted virtual machine monitor that can emulate a host processor
via dynamic binary translation. On common host platforms QEMU can also use
a host provided virtualization layer, which is faster than dynamic binary
translation.

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
$ sudo shutdown now
```

