From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 14 Sep 2017 13:44:14 +0200
Subject: [PATCH v2 1/2] watchdog: dw_wdt: add stop watchdog operation
In-Reply-To: <20170914113013.19157-1-o.rempel@pengutronix.de>
References: <20170914113013.19157-1-o.rempel@pengutronix.de>
Message-ID: <1505389454.10100.5.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-09-14 at 13:30 +0200, Oleksij Rempel wrote:
> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 
> The only way of stopping the watchdog is by resetting it.
> Add the watchdog op for stopping the device and reset if
> a reset line is provided.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog at vger.kernel.org

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
