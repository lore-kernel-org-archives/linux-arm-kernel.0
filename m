From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 7 Apr 2015 09:56:42 +0200
Subject: [PATCH v5 10/15] serial: stm32-usart: Add STM32 USART Driver
In-Reply-To: <1428083006.13180.35.camel@perches.com>
References: <1428080481-18591-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1428080481-18591-11-git-send-email-mcoquelin.stm32@gmail.com>
 <1428083006.13180.35.camel@perches.com>
Message-ID: <CALszF6CFBm5jJUF95K=6_gRHijSk3Addpw13_q3Li-i8fqP6tA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-03 19:43 GMT+02:00 Joe Perches <joe@perches.com>:
> On Fri, 2015-04-03 at 19:01 +0200, Maxime Coquelin wrote:
>> This drivers adds support to the STM32 USART controller, which is a
>> standard serial driver.
>
> trivia:
>
>> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> []
>> +static struct uart_ops stm32_uart_ops = {
>
> could be const

i would even say, should be const.

>
> and it could be updated in a separate patch later too.
>

Nope, I will send another version anyway, so it will be part of the v6.

Thanks for the review,
Maxime
