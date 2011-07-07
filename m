From: vkoul@infradead.org (Vinod Koul)
Date: Thu, 07 Jul 2011 07:05:28 +0530
Subject: [PATCH] ARM i.MX dma: Fix burstsize settings
In-Reply-To: <20110706150356.GA11993@opensource.wolfsonmicro.com>
References: <20110706091833.GT6069@pengutronix.de>
	<20110706150356.GA11993@opensource.wolfsonmicro.com>
Message-ID: <1310002528.20150.3.camel@psiaudioba-mobl1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-07-06 at 08:03 -0700, Mark Brown wrote:
> On Wed, Jul 06, 2011 at 11:18:33AM +0200, Sascha Hauer wrote:
> > dmaengine expects the maxburst parameter in words, not bytes.
> > The imxdma driver and its users do this wrong. Fix this.
> > 
> > As a side note the imx-pcm-dma-mx2 driver was 'fixed' to work
> > with imx-dma. This broke the driver with imx-sdma support which
> > correctly takes the maxburst parameter in words. This patch
> > puts the sdma based sound back to work.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>

> 
> Probably makes sense to send via the ARM tree unless there's merge
> issues?
Sure, I dont have naything on this driver in my next and previous
updates for Sascha went thru imx tree, so would make sense for these to
go that way as well

~Vinod Koul
Intel Corp.
