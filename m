From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 21 Feb 2017 13:46:26 +0100
Subject: [PATCH] tty/serial: atmel: increase ATMEL_MAX_UART
In-Reply-To: <20170221120357.13623-1-alexandre.belloni@free-electrons.com>
References: <20170221120357.13623-1-alexandre.belloni@free-electrons.com>
Message-ID: <CACQ1gAgkqRPdVCU+cmUdaANVXygB4pC40+u1pPwpervAJ4+Q8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-02-21 13:03 GMT+01:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> The samx7 family uses the same UART/USART IP as the at91/sama5 families but
> has 8 of those.
>
> Suggested-by: Szemz? Andr?s <sza@esh.hu>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Richard Genoud <richard.genoud@gmail.com>

> ---
>  drivers/tty/serial/atmel_serial.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index f0d4894267c2..8cc152e67bfb 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -119,8 +119,9 @@ struct atmel_uart_char {
>  /*
>   * at91: 6 USARTs and one DBGU port (SAM9260)
>   * avr32: 4
> + * samx7: 3 USARTs and 5 UARTs
>   */
> -#define ATMEL_MAX_UART         7
> +#define ATMEL_MAX_UART         8
>
>  /*
>   * We wrap our port structure around the generic uart_port.
> --
> 2.11.0
>

Thanks !
