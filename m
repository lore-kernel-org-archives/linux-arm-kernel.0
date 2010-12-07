From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 7 Dec 2010 13:06:02 +0100
Subject: [PATCH] watchdog: imx: use clk_get to acquire the watchdog clock
In-Reply-To: <1291664293-28360-1-git-send-email-fabio.estevam@freescale.com>
References: <1291664293-28360-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20101207120602.GA4134@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 06, 2010 at 05:38:13PM -0200, Fabio Estevam wrote:
> Use clk_get to acquire the watchdog clock and also avoid hardcoding the clock name.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

Thanks!

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101207/4274f285/attachment.sig>
