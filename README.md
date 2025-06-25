# Float Self Tagging Artifact

Name: Float Self-Tagging (FST)

  * URL: https://zenodo.org/records/XXX
  * GITHUB: git@github.com:omelancon/fst-artifact


## Artifact Instructions

This artifact can be installed and ran either:

  1. using the VM available at https://zenodo.org/records/XXXX
  2. using the a native installation. 


### Alternative 1: VM-base artifact

The VM provides a complete Linux image where a native version
of the artifact has been pre-installed. 

To execute the artifact via the VM distribution, install QEMU and run
the virtual machine as instructed in Section [QEMU Instructions/QEMU
Startup] (see below). Once connected to the VM go into the
`fst-artifact` directory. It contains a pre-installed native version
of the artifact (as documented in Section [Native Artifact]). To
execute it:

```shell
ROOT=$HOME ./script/run.sh
```

This generates the PDF figures in the YYY directory comparing the
performance of "float self tagging" to other float implementation
techniques.


### Alternative 2: Native artifact

In order to install the version of the FST artifact, a full development
tool kit is required. It must at least contain:

  - a full-fledged C compiler
  - a full-fledged "make" tool
  - a posix shell
  - gnuplot for generating the barcharts

Under Linux Debian or Ubuntu the requirements can be installed with:

```shell
apt update
sudo apt dist-upgrade
sudo apt install -y libgmp-dev libgmp10 autoconf automake libtool libunistring-dev gnuplot
```

One the requirements are installed and operational, clone the [GITHUB]
(see above) repository and install all the compilers and benchmarks
needed to produce the figures using the following command (which maybe
last around 2 hours):

```shell
ROOT=$HOME ./script/install.sh
```

This creates two directories:

  - `download`: all the sources or all the compilers and benchmarks
  - `install`: all the compilers binary files.
  
  
To run the artifact, proceed as for the VM-base implementation, that is:

```shell
ROOT=$HOME ./script/run.sh
```

This creates all figures in the YYYY directory. On a fast machine, this
command lasts about 4 hours.


## QEMU Instructions

The Float Self-Tagging is using a Debian QEMU image as a base for
artifacts. QEMU is a hosted virtual machine monitor that can emulate a
host processor via dynamic binary translation. On common host
platforms QEMU can also use a host provided virtualization layer,
which is faster than dynamic binary translation.

QEMU homepage: https://www.qemu.org/


### QEMU Installation

#### OSX

```shell
brew install qemu
```

#### Debian and Ubuntu Linux

```shell
apt-get install qemu-kvm
```

On x86 laptops and server machines you may need to enable the "Intel
Virtualization Technology" setting in your BIOS, as some manufacturers
leave this disabled by default. See Debugging.md for details.


#### Arch Linux

```shell
pacman -Sy qemu
```

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


### QEMU Installation Creation

The file `qemu/ImageCreation.md` contains a complete manual on how
to install Linux on a bare QEMU. You only need to follow this steps
if you decide not to use the pre-installed image which is shipped
with this artifact.


### QEMU Startup

The base artifact provides a script to start the VM on unix-like systems:

  `qemu/start.sh` 
  
On Window, use the script:

  `qemu/start.bat` 
  
Running this script will open a graphical console on the host machine,
and create a virtualized network interface. On Linux you may need to
run with `sudo` to start the VM. If the VM does not start then check
`qemu/Debugging.md`

Once the VM has started you can login to the guest system from the
host.  Whenever you are asked for a password, the answer is
`password`. The default username is `artifact`.

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
(qemu) git clone [GITHUB] # see above the definition of GITHUB
```


