From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Wed, 25 May 2011 22:00:55 +0300
Subject: [PATCH 1/5] dmaengine: add ep93xx DMA support
In-Reply-To: <1306310403.30236.94.camel@vkoul-udesk3>
References: <cover.1306082097.git.mika.westerberg@iki.fi>
	<e6777eb9f7228ee1dadec1f0c9f16c3afc44c307.1306082097.git.mika.westerberg@iki.fi>
	<1306310403.30236.94.camel@vkoul-udesk3>
Message-ID: <20110525190055.GB2996@acer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2011 at 01:30:03PM +0530, Koul, Vinod wrote:
> 
> Which tree are these patches going thru?

I was hoping that the dmaengine driver itself would go via dmaengine tree (is
it you or Dan who maintain it?) and rest of the patches probably through their
respective trees. However, since there are dependencies between the patches,
I'm not entirely sure how to proceed with these. Any ideas appreciated :)

Fortunately arch/arm/configs/ep93xx_defconfig doesn't have audio nor SPI
enabled by default so it shouldn't matter if the patches go out of order to
the mainline.

Thanks,
MW
