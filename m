From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 6 Jun 2013 23:00:14 +0800
Subject: [PATCH v2] ARM: imx: Remove mxc specific ulpi access ops
In-Reply-To: <1370522517-2873-1-git-send-email-mpa@pengutronix.de>
References: <1370522517-2873-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20130606150012.GC28270@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 06, 2013 at 02:41:57PM +0200, Markus Pargmann wrote:
> There are ulpi access ops implemented in drivers/usb/phy/phy-ulpi.c.
> mxc access ops implement the same access operations within mach-imx. This
> patch removes the mxc ulpi file and uses phy-ulpi instead for
> imx_otg_ulpi_create.
> 
> phy-ulpi successfully tested with i.MX27 Phytec phyCARD-S (pca100).
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied, thanks.

Shawn
