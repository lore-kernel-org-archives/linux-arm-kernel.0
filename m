From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 7 Mar 2011 09:18:37 +0100
Subject: [PATCH 0/4] Add framebuffer device for mx28evk and mx23evk boards
In-Reply-To: <1299343222-30670-1-git-send-email-shawn.guo@freescale.com>
References: <1299343222-30670-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110307081837.GJ29521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 06, 2011 at 12:40:18AM +0800, Shawn Guo wrote:
> This patch set is to add framebuffer device for mx28evk and mx23evk
> boards.  A couple notes here:
> 
> * The patch [PATCH 3/4] was cherry-picked from mxs-mmc-device patch
>   set  (Sascha, it seems dma, mmc, flexcan platform patches are all
>   waiting for your merging, please let me know if there are still
>   something stopping your pick them up)

I just applied dma and flexcan. mmc will have to wait until the
mmc driver is merged because currently we do not have the platform_data
declaration.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
