From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 15 Dec 2011 17:08:05 +0800
Subject: [PATCH] serial/imx: let probing fail for the dt case without a
 valid alias
In-Reply-To: <1323936994-2250-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20111215021046.GD3259@S2101-09.ap.freescale.net>
 <1323936994-2250-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20111215090804.GC22541@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2011 at 09:16:34AM +0100, Uwe Kleine-K?nig wrote:
> When the uart device is instantiated by dt but dt doesn't provide an
> alias then better let probing fail instead of falling back to an
> unrelated device id used for the line number and no platform data.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---

Acked-by: Shawn Guo <shawn.guo@linaro.org>
