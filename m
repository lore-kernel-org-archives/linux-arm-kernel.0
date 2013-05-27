From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 27 May 2013 11:01:35 +0200
Subject: [PATCH v7 1/2] dma: imx-dma: Add oftree support
In-Reply-To: <1369562001-11494-2-git-send-email-mpa@pengutronix.de>
References: <1369562001-11494-1-git-send-email-mpa@pengutronix.de>
 <1369562001-11494-2-git-send-email-mpa@pengutronix.de>
Message-ID: <20130527090135.GJ32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 26, 2013 at 11:53:20AM +0200, Markus Pargmann wrote:
> Adding devicetree support for imx-dma driver. Use driver name for
> function 'imx_dma_is_general_purpose' because the devicename for
> devicetree initialized devices is different.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

I haven't followed the DMA bindings discussion closely, so I can't say
much to this, but from my POV:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
