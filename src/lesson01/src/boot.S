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
	adr	x0, bss_begin
	adr	x1, bss_end
	sub	x1, x1, x0		// Calculate BSS size into x1 (x1 is passed as argument to memzero)
	bl 	memzero 		// Clear BSS

	mov	sp, #LOW_MEMORY // Set stack pointer
	bl	kernel_main		// Call kernel_main

	b 	proc_hang		// should never come here
