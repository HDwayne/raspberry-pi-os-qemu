#ifndef	_P_GPIO_H
#define	_P_GPIO_H

#include "peripherals/base.h"

// BCM (Broadcom) peripherals base address
// https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf
// Page 90 & 91, 6-1: Register View

#define GPFSEL1         (PBASE+0x00200004) // GPIO Function Select 1
#define GPSET0          (PBASE+0x0020001C) // GPIO Pin Output Set 0
#define GPCLR0          (PBASE+0x00200028) // GPIO Pin Output Clear 0
#define GPPUD           (PBASE+0x00200094) // GPIO Pin Pull-up/down Enable
#define GPPUDCLK0       (PBASE+0x00200098) // GPIO Pin Pull-up/down Enable Clock 0

#endif  /*_P_GPIO_H */
