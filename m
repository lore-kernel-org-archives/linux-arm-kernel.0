From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 25 May 2014 23:57:56 +0200
Subject: [PATCH] serial: efm32: add module_exit
In-Reply-To: <1401052385-3786-1-git-send-email-vincent.stehle@laposte.net>
References: <1401052385-3786-1-git-send-email-vincent.stehle@laposte.net>
Message-ID: <20140525215756.GA18901@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 25, 2014 at 11:13:05PM +0200, Vincent Stehl? wrote:
> Add missing specification of efm32_uart_exit as module_exit.
> 
> This fixes the following compilation warning:
> 
>   drivers/tty/serial/efm32-uart.c:840:123: warning: ?efm32_uart_exit? defined but not used [-Wunused-function]
This warning doesn't occur in my builds, probably because I have
MODULES=n. I can reproduce it on allmodconfig though.
 
> Signed-off-by: Vincent Stehl? <vincent.stehle@laposte.net>
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
