From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 9 Mar 2012 18:44:11 +0100
Subject: [PATCH v3 00/13] dmaengine: imx-dma: merge dma arch code into
 dmaengine.
In-Reply-To: <1331306449-28591-1-git-send-email-javier.martin@vista-silicon.com>
References: <1331306449-28591-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <20120309174411.GI3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2012 at 04:20:36PM +0100, Javier Martin wrote:
> The following series have to be applied on top of the following patches:
> [PATCH v2 1/2] dmaengine: Add support for MEMCPY for imx-dma.
> [PATCH v3 2/2] dmaengine: Add support for multiple descriptors for imx-dma.
> 
> As discussed with Vinod and Sascha, the file 'arch/arm/mach-imx/dma-v1.c'
> is deprecated and no new patches are accepted for it.
> 
> This series merges this code into the imx-dma.c dmaengine driver.

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
