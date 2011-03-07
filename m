From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 7 Mar 2011 16:37:54 +0800
Subject: [PATCH 0/4] Add framebuffer device for mx28evk and mx23evk boards
In-Reply-To: <20110307081837.GJ29521@pengutronix.de>
References: <1299343222-30670-1-git-send-email-shawn.guo@freescale.com>
	<20110307081837.GJ29521@pengutronix.de>
Message-ID: <20110307083753.GC12291@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, Mar 07, 2011 at 09:18:37AM +0100, Sascha Hauer wrote:
> On Sun, Mar 06, 2011 at 12:40:18AM +0800, Shawn Guo wrote:
> > This patch set is to add framebuffer device for mx28evk and mx23evk
> > boards.  A couple notes here:
> > 
> > * The patch [PATCH 3/4] was cherry-picked from mxs-mmc-device patch
> >   set  (Sascha, it seems dma, mmc, flexcan platform patches are all
> >   waiting for your merging, please let me know if there are still
> >   something stopping your pick them up)
> 
> I just applied dma and flexcan. mmc will have to wait until the
> mmc driver is merged because currently we do not have the platform_data
> declaration.
> 
The mmc driver has been merged on cjb's tree for some while, so we
are waiting it gets merged on your tree, right?

-- 
Regards,
Shawn
