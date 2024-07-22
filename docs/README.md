# A tiny, modern kernel for Raspberry Pi 3
A tiny kernel *incrementally built* for OS education.
Start with minimal, baremetal code. Then add kernel features in small doses.

Each experiment is self-contained and can run on both Rpi3 hardware and QEMU.
Experiment descriptions are for you to read & reproduce.

**Get the code**:

```sh
git clone https://github.com/mpoquet/raspberry-pi-os-qemu
```

## Rationale
The kernel must run on cheap & modern hardware.
Showing the kernel's evolution path is important.
Along the path, each version must be self-contained and runnable.

We deem the following kernel functions crucial to implement:
* protection modes
* interrupt handling
* preemptive scheduling
* virtual memory

Experimenting with these features is difficult with commodity kernels due to their complexity.

## Goals
**Primary:**
* Learning by doing: the core concepts of a modern OS kernel
* Experiencing OS engineering: hands-on programming & debugging at the hardware/software boundary
* Daring to plumb: working with baremetal hardware: CPU protection modes, registers, IO, MMU, etc.

**Secondary:**
* Aarch64 programming
* Working with C and assembly
* Cross-platform development

**Non-goals:**
* Non-core or advanced functions of OS kernel, *e.g.*, filesystem or power management, which can be learnt via experimenting with commodity OS
* Rpi3-specific hardware details. The SoC of Rpi3 is notoriously unfriendly to kernel hackers
* Implementation details of commodity kernels, *e.g.*, Linux or Windows

## Documentation
* [Aarch64 cheatsheet](aarch64-cheatsheet.md)
  * [Official Aarch64 ISA doc](https://developer.arm.com/documentation/ddi0602/latest/)
  * [Official Aarch64 registers doc](https://developer.arm.com/documentation/ddi0601/latest/)
  * [Official Aarch64/Aarch32 address translation doc](https://developer.arm.com/documentation/100940/latest/)
* [QEMU cheetsheet](qemu.md)
* [Using GDB to debug kernel](gdb.md)
* [Inspect kernel binary](inspect-kernel-binary.md)

## Experiments
0. **Getting started**
      * [Sharpen your tools!](lesson00/rpi-os.md)
1. **Helloworld from baremetal**
      * [Power on + UART bring up](lesson01/rpi-os.md)
2. **Exception elevated**
      * [CPU initialization, exception levels](lesson02/rpi-os.md)
3. **Heartbeats on**
      * [Interrupt handling](lesson03/rpi-os.md)
4. **Process scheduler**
      * [A. Cooperative](lesson04a/rpi-os.md)
      * [B. Preemptive](lesson04b/rpi-os.md)
5. **A world of two lands**
      * [User processes and system calls](lesson05/rpi-os.md)
6. **Into virtual**
      * [Virtual memory management](lesson06/rpi-os.md)

## Acknowledgements
1. Sergey Matyukevich, Alexandre Venito et al. made the educational kernel and most of the resources in https://github.com/s-matyukevich/raspberry-pi-os
2. Felix Xiaozhu Lin et al. adapted the codebase to make it work on QEMU and improved the content in https://github.com/fxlin/p1-kernel
3. Millian Poquet adapted the codebase for its operating system design course.
