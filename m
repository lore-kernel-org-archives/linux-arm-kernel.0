From: vinod.koul@intel.com (Koul, Vinod)
Date: Wed, 25 May 2011 13:30:03 +0530
Subject: [PATCH 1/5] dmaengine: add ep93xx DMA support
In-Reply-To: <e6777eb9f7228ee1dadec1f0c9f16c3afc44c307.1306082097.git.mika.westerberg@iki.fi>
References: <cover.1306082097.git.mika.westerberg@iki.fi>
	<e6777eb9f7228ee1dadec1f0c9f16c3afc44c307.1306082097.git.mika.westerberg@iki.fi>
Message-ID: <1306310403.30236.94.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2011-05-22 at 20:03 +0300, Mika Westerberg wrote:
> The ep93xx DMA controller has 10 independent memory to peripheral (M2P)
> channels, and 2 dedicated memory to memory (M2M) channels. M2M channels can
> also be used by SPI and IDE to perform DMA transfers to/from their memory
> mapped FIFOs.
> 
> This driver supports both M2P and M2M channels with DMA_SLAVE, DMA_CYCLIC and
> DMA_MEMCPY (M2M only) capabilities.
> 
Acked-by: Vinod Koul <vinod.koul@intel.com>

Which tree are these patches going thru?

-- 
~Vinod
