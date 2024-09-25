#include "arm/sysregs.h"

#include "mm.h"

// MRS - Move from system register.
// ADR - Load the address of a label into a register.

.section ".text.boot"	// Place the code in the .text.boot section (linker script)

.globl _start
_start:
	mrs	x0, mpidr_el1 	// https://developer.arm.com/documentation/ddi0500/j/System-Control/AArch64-register-descriptions/Multiprocessor-Affinity-Register
	and	x0, x0,#0xFF	// look at Aff0 [7:0] bits. This is the CPU ID.
	cbz	x0, master		// Master processor (id=0) goes to master
	b	proc_hang		// Other processors hang

proc_hang:				// Hang here infinitely
	b 	proc_hang

master:
	ldr	x0, =SCTLR_VALUE_MMU_DISABLED
	msr	sctlr_el1, x0 	// SCTLR. data little-endian, instruction cache disabled, data cache disabled, MMU disabled

	ldr	x0, =HCR_VALUE
	msr	hcr_el2, x0		// Hypervisor Configuration Register. EL1 is AArch64, EL0 is AArch64

#ifdef USE_QEMU 		// QEMU Emulator (from EL2)

	ldr	x0, =SPSR_VALUE
	msr	spsr_el2, x0	// Saved Program Status Register (EL3).

	#adr x0, kernel_entry
	adr x0, switch_to_el0
	msr	elr_el2, x0		// EL2 to point to entry point for EL1.

#else 					// Raspberry Pi 3 Hardware (from EL3)

	ldr	x0, =SCR_VALUE
	msr	scr_el3, x0		// Secure Configuration Register. EL3 is in AArch64 state, EL3 is in Non-secure state

	ldr	x0, =SPSR_VALUE
	msr	spsr_el3, x0	// EL2 to mask all interrupts and set the processor state

	adr	x0, el1_entry
	msr	elr_el3, x0		// EL3 to point to entry point for EL1.

#endif

	eret

switch_to_el0:
    ldr x0, =SPSR_VALUE_EL0
    msr spsr_el1, x0

    adr x0, kernel_entry
    msr elr_el1, x0
    eret

el1_entry:
	adr	x0, bss_begin
	adr	x1, bss_end
	sub	x1, x1, x0		// Calculate BSS size into x1 (x1 is passed as argument to memzero)
	bl 	memzero 		// Clear BSS

kernel_entry:
	mov	sp, #LOW_MEMORY
    bl kernel_main
    b proc_hang			// Infinite loop (shouldn't return).

