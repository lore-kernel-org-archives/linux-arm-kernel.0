From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 30 Jan 2013 18:35:34 +0800
Subject: [PATCH v6 08/10] spi: omap2-mcspi: convert to
 dma_request_slave_channel_compat()
In-Reply-To: <1359529229-22207-9-git-send-email-mporter@ti.com>
References: <1359529229-22207-1-git-send-email-mporter@ti.com>
 <1359529229-22207-9-git-send-email-mporter@ti.com>
Message-ID: <20130130103530.GA6229@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 02:00:27AM -0500, Matt Porter wrote:
> Convert dmaengine channel requests to use
> dma_request_slave_channel_compat(). This supports the DT case of
> platforms requiring channel selection from either the OMAP DMA or
> the EDMA engine. AM33xx only boots from DT and is the only user
> implementing EDMA so in the !DT case we can default to the OMAP DMA
> filter.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
