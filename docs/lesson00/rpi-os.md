# 0: Sharpen your tools

**Get the code**:

```
git clone https://github.com/mpoquet/raspberry-pi-os-qemu
```

### Terms

baremetal; kernel; kernel binary; kernel image

## Dev environment

This is where you develop kernel code.

### Toolchain

These are compiler, linker, etc. for us to generate the kernel code. Use the one provided by Ubuntu.

```
# this is necessary only when you develop kernel code on your local machine
# the server already has the toolchain installed
$ sudo apt install gcc-aarch64-linux-gnu
$ sudo apt install gdb-multiarch

$ aarch64-linux-gnu-gcc --version
aarch64-linux-gnu-gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0
```

## Test Platform

This is where you run the kernel code.


#### Test the compilation

Test QEMU with Rpi3 baremetal code (NOTE: this repo is for validating your toolchain & QEMU build; it is NOT our course project)

```
git clone https://github.com/fxlin/raspi3-tutorial.git
cd raspi3-tutorial
git checkout b026449
cd 05_uart0
make
qemu-system-aarch64 -M raspi3 -kernel kernel8.img -serial stdio
```

If everything works fine, you should see QMEU print out:

```
My serial number is: 0000000000000000
```
>  Note: the test program runs an infinite loop which will cause high CPU usage on your host machine. Kill the test program timely.

![](test-qemu.gif)

Move to [the QEMU cheatsheet](../qemu.md).
