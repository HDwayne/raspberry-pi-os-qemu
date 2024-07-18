# QEMU cheetsheet

## Sample kernel binary for testing

To test whether your QEMU installation works you can download a (tiny) kernel that prints `Hello, world!` then prints what you type, with the following command.

```sh
wget https://github.com/fxlin/p1-kernel/releases/download/exp1-qemu/kernel8.img
```

## Launch the kernel, free run

```sh
qemu-system-aarch64 -machine raspi3b -serial null -serial mon:stdio -nographic -kernel ./kernel8.img
```

Explanation:
* `-machine` sets the machine type
* Two `-serial` options correspond to the two UARTs of Rpi3 as emulated by QEMU. **Note:** Our kernel writes message to the 2nd one. So we tell QEMU to redirect the 2nd UART to stdio.

## Launch the kernel, for GDB debugging

```sh
# will wait for gdb to connect at local tcp 1234
qemu-system-aarch64 -machine raspi3b -serial null -serial mon:stdio -nographic -kernel ./kernel8.img -s -S

# will wait for gdb to connect at local tcp 5678
qemu-system-aarch64 -machine raspi3b -serial null -serial mon:stdio -nographic -kernel ./kernel8.img -gdb tcp::5678 -S
```

Explanation:
* `-S` not starting the guest until you tell it to from `gdb`.
* `-s` listening for an incoming connection from gdb on TCP port 1234

## Launch the kernel with monitor
```sh
qemu-system-aarch64 -machine raspi3b -kernel ./kernel8.img -monitor stdio
# multiplex both board serial and monitor output on stdio
qemu-system-aarch64 -machine raspi3b -serial null -serial mon:stdio -kernel kernel8.img
```
More on [the monitor mode](https://en.wikibooks.org/wiki/QEMU/Monitor).

## Launch the kernel with tracing
```sh
qemu-system-aarch64 -machine raspi3b -kernel ./kernel8.img -serial null -serial stdio -d int -D qemu.log
```
Explanation: `-d int` ---> enable interrupt dedug       `-D test.log`  ----> put debug msg to a file `qemu.log`

Sample log:

```
Exception return from AArch64 EL2 to AArch64 EL1 PC 0x80038
Taking exception 5 [IRQ]
...from EL1 to EL1
...with ESR 0x0/0x0
...with ELR 0x8095c
...to EL1 PC 0x81a80 PSTATE 0x3c5
Exception return from AArch64 EL1 to AArch64 EL1 PC 0x8095c
Taking exception 5 [IRQ]
...from EL1 to EL1
...with ESR 0x0/0x0
...with ELR 0x8095c
...to EL1 PC 0x81a80 PSTATE 0x3c5
Exception return from AArch64 EL1 to AArch64 EL1 PC 0x8095c
Taking exception 5 [IRQ]
...from EL1 to EL1
...with ESR 0x0/0x0
...with ELR 0x8095c
...to EL1 PC 0x81a80 PSTATE 0x3c5
Exception return from AArch64 EL1 to AArch64 EL1 PC 0x8095c
Taking exception 5 [IRQ]
...from EL1 to EL1
...with ESR 0x0/0x0
...with ELR 0x8095c
...to EL1 PC 0x81a80 PSTATE 0x3c5
Exception return from AArch64 EL1 to AArch64 EL1 PC 0x8095c
```

Explanation: ESR - exception syndrome register, encoding the cause of the exception. ELR - exception link register, containing the return address of the exception handler. PSTATE - CPU flags when the exception is taken

## Reference
- https://wiki.osdev.org/QEMU
- https://github.com/qemu/qemu/blob/master/qemu-options.hx
