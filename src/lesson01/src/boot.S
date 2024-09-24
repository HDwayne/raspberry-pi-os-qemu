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
	ldr	x0, =SCTLR_VALUE_MMU_DISABLED // System control register
	msr	sctlr_el1, x0

	ldr	x0, =HCR_VALUE  	// Hypervisor Configuration (EL2)
	msr	hcr_el2, x0

#ifdef USE_QEMU 		// xzl: qemu boots from EL2. cannot do things to EL3
	ldr	x0, =SPSR_VALUE
	msr	spsr_el2, x0

	#adr	x0, el1_entry
	adr x0, el1_entry_another
	msr	elr_el2, x0
#else 					// xzl: Rpi3 hw boots from EL3.
	ldr	x0, =SCR_VALUE	// Secure config register. Only at EL3.
	msr	scr_el3, x0

	ldr	x0, =SPSR_VALUE
	msr	spsr_el3, x0

	adr	x0, el1_entry
	msr	elr_el3, x0
#endif

	eret

el1_entry:
	adr	x0, bss_begin
	adr	x1, bss_end
	sub	x1, x1, x0		// Calculate BSS size into x1 (x1 is passed as argument to memzero)
	bl 	memzero 		// Clear BSS

el1_entry_another:
	mov	sp, #LOW_MEMORY // Set stack pointer
	bl	kernel_main		// Call kernel_main
	b 	proc_hang		// should never come here
