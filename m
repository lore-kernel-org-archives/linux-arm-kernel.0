From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 12 May 2017 22:17:03 +0200
Subject: [PATCH V2] serial: efm32: Fix parity management in
 'efm32_uart_console_get_options()'
In-Reply-To: <20170512143545.15394-1-christophe.jaillet@wanadoo.fr>
References: <20170512143545.15394-1-christophe.jaillet@wanadoo.fr>
Message-ID: <20170512201703.puk6xit34d3dnddv@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 04:35:45PM +0200, Christophe JAILLET wrote:
> UARTn_FRAME_PARITY_ODD is 0x0300
> UARTn_FRAME_PARITY_EVEN is 0x0200
> So if the UART is configured for EVEN parity, it would be reported as ODD.
> Fix it by correctly testing if the 2 bits are set.
> 
> Fixes: 3afbd89c9639 ("serial/efm32: add new driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks for picking this topic up again.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
