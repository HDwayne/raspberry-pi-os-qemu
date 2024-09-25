#ifndef _SYSREGS_H
#define _SYSREGS_H


// ***************************************
// SCTLR_EL1, System Control Register (EL1), Page 2654 of AArch64-Reference-Manual.
// ***************************************

#define SCTLR_RESERVED                  (3 << 28) | (3 << 22) | (1 << 20) | (1 << 11)
#define SCTLR_EE_LITTLE_ENDIAN          (0 << 25)   // Little-endian for data. Means the least significant byte is stored at the lowest memory address.
#define SCTLR_EOE_LITTLE_ENDIAN         (0 << 24)   // Little-endian for exceptions.
#define SCTLR_I_CACHE_DISABLED          (0 << 12)   // Instruction cache disabled.
#define SCTLR_D_CACHE_DISABLED          (0 << 2)    // Data cache disabled.
#define SCTLR_MMU_DISABLED              (0 << 0)    // MMU disabled.
#define SCTLR_MMU_ENABLED               (1 << 0)    // MMU enabled.

/* 
    SCTLR register value when MMU is disabled.
    - Reserved bits in SCTLR register.
    - Little-endian for data.
    - Instruction cache disabled.
    - Data cache disabled.
    - MMU disabled. 
*/
#define SCTLR_VALUE_MMU_DISABLED	(SCTLR_RESERVED | SCTLR_EE_LITTLE_ENDIAN | SCTLR_I_CACHE_DISABLED | SCTLR_D_CACHE_DISABLED | SCTLR_MMU_DISABLED)

// ***************************************
// HCR_EL2, Hypervisor Configuration Register (EL2), Page 2487 of AArch64-Reference-Manual.
// ***************************************

#define HCR_RW      (1 << 31)   // Ensure that EL1 and EL0 are in AArch64 state (64-bit).
#define HCR_VALUE   HCR_RW      // Set the value of HCR register.

// ***************************************
// SCR_EL3, Secure Configuration Register (EL3), Page 2648 of AArch64-Reference-Manual.
// ***************************************

#define SCR_RESERVED    (3 << 4)
#define SCR_RW          (1 << 10)   // EL3 and lower levels are in AArch64 state.
#define SCR_NS          (1 << 0)    // EL3 is in Non-secure state.

/* 
Set the value of SCR register.
- Reserved bits in SCR register.
- EL3 and lower levels are in AArch64 state.
- EL3 is in Non-secure state.
*/
#define SCR_VALUE       (SCR_RESERVED | SCR_RW | SCR_NS)

// ***************************************
// SPSR_EL3, Saved Program Status Register (EL3) Page 389 of AArch64-Reference-Manual.
// ***************************************

/* 
Set bits 6, 7, and 8 of SPSR register to 1.
ALL interrupts are disabled. SErrors are disabled.
- Bits 6: FIQ interrupt mask bit.
- Bits 7: IRQ interrupt mask bit.
- Bits 8: SError interrupt mask bit.
*/
#define SPSR_MASK_ALL   (7 << 6)

#define SPSR_EL1h       (5 << 0)
#define SPSR_VALUE      (SPSR_MASK_ALL | SPSR_EL1h)


// ***************************************
// SPSR_EL0
// ***************************************

#define SPSR_EL0            (0 << 0)
#define SPSR_VALUE_EL0      (SPSR_MASK_ALL | SPSR_EL0)

#endif
