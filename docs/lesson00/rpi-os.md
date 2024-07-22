# 0: Sharpen your tools
**Get the code**:
```sh
git clone https://github.com/mpoquet/raspberry-pi-os-qemu
```

## Development toolchain
### Compilation
- If your host machine runs on Linux but not on Aarch64,
  you need a `gcc` cross-compilation toolchain that targets the Aarch64 architecture.
  All decent Linux distributions should directly provide such toolchain in their packages.
  A Nix flake is provided at the root of this repository to install a tested cross-compilation toolchain on any Linux.
- If your host machine already runs an Aarch64 Linux, you just need a normal `gcc` compilation toolchain.
- If you are running MacOS on Aarch64, you can try `aarch64-elf-gcc` on homebrew.
- If you are not running Linux, install a Linux.
  A VM installation should be enough, as we will not measure performance overhead in this course.

### Other tools
- You need a way to run the provided Makefiles. They have been tested using `gnumake-4.4.1`.
- Having a debugger that understands aarch64 is highly recommended. The provided tested debugger is `gdb-14.2`.
- Utilities to inspect binary files is recommended. These tools are very often packaged as `binutils`.

### Testing your development toolchain
#### Environment configuration
The provided Makefiles rely on the `CHAINPREFIX` environment variable to call `gcc`, `ld` and `objcopy`.
You must set this environment variable appropriately depending on the exact name of the (cross) compilation binaries you use.
- Example 1: If you use the provided Nix environment, `CHAINPREFIX` is already set to `aarch64-unknown-linux-gnu-` as the cross-compilation gcc binary should be named `aarch64-unknown-linux-gnu-gcc`.
- Example 2: If you do not need cross-compilation toolchain, `CHAINPREFIX` should be empty as the gcc binary should be named `gcc`.

To test if your configuration if correct, check whether the following three commands work.

```sh
${CHAINPREFIX}gcc --version
${CHAINPREFIX}ld --version
${CHAINPREFIX}objcopy --version
```

#### Build kernel of lesson01

0. (Download and go into this course git repo: `git clone https://github.com/mpoquet/raspberry-pi-os-qemu && cd raspberry-pi-os-qemu`)
1. Go into the lesson01 directory: `cd src/lesson01`
2. Compile the kernel: `make`
   **Note**: it should not generate any error if your configuration is correct
3. A `kernel8.img` file should now be present in your directory

## Test Platform

This is where you run the kernel code.

### QEMU
We will only run the kernels via [QEMU](https://www.qemu.org/) in this course.

You need a QEMU that supports target architecture Aarch64, and that can run systems (not only user programs).
Such a QEMU should be available in any decent Linux distribution. For MacOS users, the `qemu` package seems to work.

The QEMU tested and provided in the Nix flake has version 8.2.4, and the provided binary is named `qemu-system-aarch64`.

Please read the [QEMU cheatsheet](../qemu.md) for more useful QEMU commands for this course.

### Testing your QEMU platform
#### Making sure QEMU is available
This command should print the QEMU version you have installed.

```sh
qemu-system-aarch64 --version
```

#### Running the lesson01 kernel
Assuming that you have already compiled the kernel of lesson01, you should be able to run it with the following command.

```sh
qemu-system-aarch64 -machine raspi3b -serial null -serial mon:stdio -nographic -kernel ./kernel8.img
```

- This kernel should print `Hello, world!` plus a newline, and then print back all characters you type in the console.
- You can quit QEMU with the following keyboard shortcut: Ctrl+A,X (First type Ctrl+A, release the two keys, then type X).
