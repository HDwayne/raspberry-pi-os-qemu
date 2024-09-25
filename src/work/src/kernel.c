#include "printf.h"
#include "utils.h"
#include "mini_uart.h"

void kernel_main(void)
{
	uart_init();
	uart_send_string("UART is working \r\n");

	init_printf(0, putc);
	printf("PRINTF is working \r\n");
/* 
	int el = get_el();
	printf("Exception level: %d \r\n", el);
 */
	while (1) {
		uart_send(uart_recv());
	}
}