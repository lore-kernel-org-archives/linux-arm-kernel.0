From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 23 Jul 2012 08:31:50 -0700
Subject: [PATCH 03/25] serial/imx: make imx_port.devdata member point to
 const data
In-Reply-To: <1343034810-3386-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-4-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120723153150.GB19571@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 11:13:08AM +0200, Uwe Kleine-K?nig wrote:
> This prepares *of_device_id.data becoming const. Without this change the
> following warning would occur:
> 
> 	drivers/tty/serial/imx.c: In function 'serial_imx_probe_dt':
> 	drivers/tty/serial/imx.c:1430:17: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
