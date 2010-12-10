From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 10 Dec 2010 14:52:47 +0100
Subject: [PATCH v2] watchdog: imx: use clk_get to acquire the watchdog
	clock
In-Reply-To: <1291738564-10374-1-git-send-email-fabio.estevam@freescale.com>
References: <1291738564-10374-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20101210135246.GJ17441@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 07, 2010 at 02:16:04PM -0200, Fabio Estevam wrote:
> Use clk_get to acquire the watchdog clock and also avoid hardcoding the clock name.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
