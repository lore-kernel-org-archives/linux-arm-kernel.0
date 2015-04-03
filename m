From: joe@perches.com (Joe Perches)
Date: Fri, 03 Apr 2015 10:43:26 -0700
Subject: [PATCH v5 10/15] serial: stm32-usart: Add STM32 USART Driver
In-Reply-To: <1428080481-18591-11-git-send-email-mcoquelin.stm32@gmail.com>
References: <1428080481-18591-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1428080481-18591-11-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1428083006.13180.35.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-04-03 at 19:01 +0200, Maxime Coquelin wrote:
> This drivers adds support to the STM32 USART controller, which is a
> standard serial driver.

trivia:

> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
[]
> +static struct uart_ops stm32_uart_ops = {

could be const

and it could be updated in a separate patch later too.
