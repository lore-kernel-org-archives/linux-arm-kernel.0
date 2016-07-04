From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 04 Jul 2016 17:43:03 +0200
Subject: [PATCH] serial: imx: add rx and tx led trigger
In-Reply-To: <1467646452-21243-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1467646452-21243-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <13559901.NSWqUx1Nl6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 4, 2016 5:34:12 PM CEST Uwe Kleine-K?nig wrote:
> Add support for two led triggers per UART instance that blink on
> transmission and reception of data respectively.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/tty/serial/imx.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)

What is specific to this driver here? Could this be done in the
core tty code instead?

	Arnd
