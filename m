From: davem@davemloft.net (David Miller)
Date: Wed, 30 Nov 2011 17:08:10 -0500 (EST)
Subject: [PATCH v3] net: fec: Select the FEC driver by default for i.MX
 SoCs
In-Reply-To: <1322664138-3245-1-git-send-email-fabio.estevam@freescale.com>
References: <1322652717-2685-1-git-send-email-fabio.estevam@freescale.com>
 <1322664138-3245-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20111130.170810.1453588817649945163.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>
Date: Wed, 30 Nov 2011 12:42:18 -0200

> Since commit 230dec6 (net/fec: add imx6q enet support) the FEC driver is no 
> longer built by default for i.MX SoCs.
> 
> Let the FEC driver be built by default again.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> Suggested-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Applied.
