From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 17 Nov 2014 08:54:56 +0100
Subject: [PATCH] dma: imx-sdma: clarify about firmware not found error
In-Reply-To: <1415829869-6661-1-git-send-email-festevam@gmail.com>
References: <1415829869-6661-1-git-send-email-festevam@gmail.com>
Message-ID: <20141117075456.GD30369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 08:04:29PM -0200, Fabio Estevam wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> When a firmware cannot be found for the SDMA engine then we can
> continue with the internal ROM firmware.
> 
> The meaning of this message is frequently asked for, so make clear
> that the driver still works with the internal ROM firmware and reduce
> the loglevel from err to info.
> 
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

I still think we should have this.

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
