From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 6 Jul 2011 08:03:57 -0700
Subject: [PATCH] ARM i.MX dma: Fix burstsize settings
In-Reply-To: <20110706091833.GT6069@pengutronix.de>
References: <20110706091833.GT6069@pengutronix.de>
Message-ID: <20110706150356.GA11993@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 11:18:33AM +0200, Sascha Hauer wrote:
> dmaengine expects the maxburst parameter in words, not bytes.
> The imxdma driver and its users do this wrong. Fix this.
> 
> As a side note the imx-pcm-dma-mx2 driver was 'fixed' to work
> with imx-dma. This broke the driver with imx-sdma support which
> correctly takes the maxburst parameter in words. This patch
> puts the sdma based sound back to work.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Probably makes sense to send via the ARM tree unless there's merge
issues?
