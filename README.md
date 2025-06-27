# Float Self Tagging Artifact

Name: Float Self-Tagging

  * DOI: 10.5281/zenodo.15741204
  * URL: https://zenodo.org/records/15741204
  * GITHUB: git@github.com:omelancon/fst-artifact

This artifact can be installed and run either:

  1. using the VM available at https://zenodo.org/records/15741204
  2. using the a native installation from git@github.com:omelancon/fst-artifact

## Introduction

This artifact evaluates the performance of float self-tagging for implementing
double-precision floats as tagged values instead of tagged pointers.

Performance is evaluated by implementing the following variants of self-tagging
in the Bigloo and Gambit Scheme compilers:

- 1-tag
- 2-tag
- 3-tag
- 4-tag (unsupported by Bigloo)

Performance of self-tagging is compared to that of other encodings for
double-precision floats, namely:

- NaN-boxing (unsupported by Gambit)
- NuN-boxing
- tagged pointers

Performance is evaluated by executing benchmarks from the R7RS Scheme benchmark
suite (https://ecraven.github.io/r7rs-benchmarks/) with each encoding,
on each compiler. Execution time and memory allocations are measured.

This artifact then generates figures for the profiled execution time, memory
allocation, branch misprediction, and impact on garbage collection.

The most straightforward way to execute this artifact is using the provided VM,
which contains a Debian QEMU image. QEMU is a hosted virtual machine monitor
that can emulate a host processor via dynamic binary translation. On common host
platforms QEMU can also use a host provided virtualization layer, which is
faster than dynamic binary translation.

QEMU homepage: https://www.qemu.org/

### Claims

All figures showing results from benchmark execution in the paper are
generated from this artifact.

Note: when the benchmarks are executed with QEMU the performance is
somewhat skewed. The results in the paper are generated on physical
hardwares to minimize secondary effects. We recommend using a similar
setting when possible.


## Hardware Dependencies

This artifact has been tested on Linux. It has no notable hardware dependency
and should run on any modern personal computer.

## Getting Started Guide

This artifact provides a VM with a complete Linux image where the
native version of the artifact has been pre-installed (as installation
of all compiler variants takes several hours).

The artifact can be either executed via the provided VM, or by
executing the native version that installs all compilers. Both
alternative are described hereafter.

## Alternative 1: VM-based artifact

**NOTE**: the QEMU VM is provided for convenience, to skip the (long) step of
installing all compilers. However, results obtained through QEMU are bound to be
noisier and less reliable. Results in the paper are obtained by directly
executing the native artifact.

To execute the artifact via the VM distribution, follow these steps.

### Install QEMU

#### on OSX

```shell
brew install qemu
```

Restart your computer.

#### on Debian and Ubuntu Linux

```shell
apt-get install qemu-kvm
```

On x86 laptops and server machines you may need to enable the "Intel
Virtualization Technology" setting in your BIOS, as some manufacturers
leave this disabled by default. See `qemu/Debugging.md` for details.

Restart your computer.


#### on Arch Linux

```shell
pacman -Sy qemu
```

See the [Arch wiki](https://wiki.archlinux.org/title/QEMU) for more info.

See Debugging.md if you have problems logging into the artifact via SSH.

Restart your computer.


#### on Windows 10

Download and install QEMU via the links at

https://www.qemu.org/download/#windows.

Ensure that `qemu-system-x86_64.exe` is in your path.

Start Bar -> Search -> "Windows Features"
          -> enable "Hyper-V" and "Windows Hypervisor Platform".

Restart your computer.

#### Windows 8

See `qemu/Debugging.md` for Windows 8 install instructions.

### Start the QEMU VM

The base artifact provides a script to start the VM on unix-like systems:

```shell
(host) qemu/start.sh
```
  
On Window, use the script:

```shell
(host) qemu/start.bat
```
  
Running this script will open a graphical console on the host machine, and
create a virtualized network interface. On Linux you may need to run with `sudo`
to start the VM. If the VM does not start then check `qemu/Debugging.md`

### Login to the VM

Once the VM has started you can login to the guest system from the host.
Whenever you are asked for a password, the answer is `password`. The default
username is `artifact`.

```
(host) ssh -p 5555 artifact@localhost
```

The artifact is in the folder `fst-artifact`

```
cd fst-artifact
```

### Run benchmarks

Run all benchmarks (takes about 10 hours):

```shell
(qemu) scripts/run.sh
```

This executes all the benchmarks and stores the results in the following
directories:

  - `stats.arfifact`: execution times;
  - `branchs.arfifact`: branch prediction statistics (*);
  - `bmems.arfifact`: memory profiling;
  - `heaps.artifact`: garbage collection impact.


(*): The branch predictions statistics can only be collected on native Linux
platforms when the `perf` tool is granted full access to the cpu sensors.
Otherwise, this benchmark is skipped.

Benchmark execution can be interrupted. When restarting (with
`scripts/run.sh`), it will restart from the benchmark that was interrupted.

### Plot Results

```shell
(qemu) scripts/plot.sh
```

This generates the PDF figures in the `plot.artifact` directory comparing the
performance of float self-tagging to other float implementation techniques.

You can copy files to and from the host using scp to extract all figures.

```shell
(host) scp -r -P 5555 artifact@localhost:fst-artifact/plot.artifact .
```

### Shutdown

To shutdown the guest system cleanly, login to it via ssh and use

```
(qemu) sudo shutdown now
```

### QEMU Installation Creation (Optional)

If you decide not to use the pre-installed image shipped with this artifact, the
file `qemu/ImageCreation.md` contains a complete manual on how to install Linux
on a bare QEMU.

Inside the bare Debian VM run the following commands:

```
(qemu) sudo apt update
(qemu) sudo apt dist-upgrade
(qemu) sudo apt install -y libgmp-dev libgmp10 autoconf automake libtool libunistring-dev gnuplot bc
(qemu) git clone https://github.com:omelancon/fst-artifact
```

## Alternative 2: Native artifact

To run the native artifact outside of the VM, a full development tool kit is
required. It must at least contain:

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

Once the requirements are installed and operational, clone the
[GITHUB] (see above) repository and install all the compilers and
benchmarks needed to produce the figures using the following command
(which takes around 4-6 hours):

```shell
(host) scripts/install.sh
```

This creates three directories:

  - `download`: all the sources or all the compilers and benchmarks
  - `install`: all the compilers binary files.
  - `log`: log files for compilations and executions.
  
To run the artifact, proceed as for the VM-based implementation, that is:

```shell
(host) scripts/run.sh
```

This creates all figures in the  `plot.XXXX` directory, where `XXXX` is the
machine name. On a fast machine, this command lasts about 10 hours.

The shell environment variable `FST_ARTIFACT_ROOT` controls, if defined, where
the `download` and `install` directories are created. By default they are
created in the current directory, i.e., the directory from which the scripts are
invoked.

## In-Depth Instructions

The artifact's benchmark suite can be parameterized by updating `env.sh`. Below are the relevant environment variables.

- `REPETITION` is the number of repetitions for each benchmark.
- `SCM_BENCHMARKS` are the profiled benchmarks from the R7RS benchmark suite.
- `SCM_FLOAT_BENCHMARKS` are the profiled benchmarks for the GC impact experiment.
- `SCM_BENCHMARKS_VECTOR_SIZES` are the vector sizes used to prepopulate the
  heap with data in the GC impact experiment. For each of these values,
  benchmarks are executed after preallocating a vector of size `(make-vector SIZE)`. This preallocates `SIZE * 8` bytes on the heap.
- `BIGLOOS` are the Bigloo variants to profile, it can include:
  - `bigloo`: original Bigloo version with tagged pointers floats.
  - `bigloo_flt1`: Bigloo with 1-tag self-tagging.
  - `bigloo_fltnz`: Bigloo with 2-tag self-tagging and preallocated zeros.
  - `bigloo_flt`: Bigloo with 3-tag self-tagging.
  - `bigloo_nan`: Bigloo with NaN-boxing.
  - `bigloo_nun`: Bigloo with NuN-boxing.
- `GAMBITS` are the Gambit variants to profile, it can include:
  - `gambit_0`: original Gambit version with tagged pointers floats.
  - `gambit_1`: Gambit with 1-tag self-tagging.
  - `gambit_2`: Gambit with 2-tag self-tagging and preallocated zeros.
  - `gambit_3`: Gambit with 3-tag self-tagging. 
  - `gambit_4`: Gambit with 4-tag self-tagging. 
  - `gambit_nun`: Gambit with NuN-boxing.

Benchmarks are executing using the `bglstone` tool, which is a wrapper around the
R7RS benchmark suite to simplify execution with Bigloo and Gambit.

## Reusability Guide

TODO TODO TODO

This artifact streamlines the benchmark process by 

https://github.com/manuel-serrano/bglstone

https://github.com/manuel-serrano/bigloo

https://github.com/gambit/gambit

TODOS:
explain env.sh
add references to gambit, bigloo, bglstone
explain that float implementations are in gambit.h and bigloo.h
pull MS changes
test plot


















