From: vinod.koul@intel.com (Koul, Vinod)
Date: Thu, 26 May 2011 10:08:10 +0530
Subject: [PATCH 1/5] dmaengine: add ep93xx DMA support
In-Reply-To: <20110525190055.GB2996@acer>
References: <cover.1306082097.git.mika.westerberg@iki.fi>
	<e6777eb9f7228ee1dadec1f0c9f16c3afc44c307.1306082097.git.mika.westerberg@iki.fi>
	<1306310403.30236.94.camel@vkoul-udesk3> <20110525190055.GB2996@acer>
Message-ID: <1306384690.30236.202.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-05-26 at 00:30 +0530, Mika Westerberg wrote:
> On Wed, May 25, 2011 at 01:30:03PM +0530, Koul, Vinod wrote:
> > 
> > Which tree are these patches going thru?
> 
> I was hoping that the dmaengine driver itself would go via dmaengine tree (is
> it you or Dan who maintain it?) and rest of the patches probably through their
> respective trees. However, since there are dependencies between the patches,
> I'm not entirely sure how to proceed with these. Any ideas appreciated :)
Okay, I can take the DMA one only. 
It stoo late for .40, I can take it for .41 or whatever that turns out to be 

> Fortunately arch/arm/configs/ep93xx_defconfig doesn't have audio nor SPI
> enabled by default so it shouldn't matter if the patches go out of order to
> the mainline.

-- 
~Vinod
