From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 23 Jul 2012 08:31:38 -0700
Subject: [PATCH 04/25] serial/mpc52xx_uart: add a const qualifier
In-Reply-To: <1343034810-3386-5-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-5-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120723153138.GA19571@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 11:13:09AM +0200, Uwe Kleine-K?nig wrote:
> This prepares *of_device_id.data becoming const. Without this change
> the following warning would occur:
> 
> 	drivers/tty/serial/mpc52xx_uart.c: In function 'mpc52xx_uart_of_enumerate':
> 	drivers/tty/serial/mpc52xx_uart.c:1440:11: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
