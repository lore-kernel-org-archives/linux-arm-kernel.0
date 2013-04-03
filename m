From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 3 Apr 2013 17:15:54 +0530
Subject: [PATCH v9 0/9] DMA Engine support for AM33XX
In-Reply-To: <1362586540-10393-1-git-send-email-mporter@ti.com>
References: <1362586540-10393-1-git-send-email-mporter@ti.com>
Message-ID: <515C1672.4060000@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matt,

On 3/6/2013 9:45 PM, Matt Porter wrote:

> This series adds DMA Engine support for AM33xx, which uses
> an EDMA DMAC. The EDMA DMAC has been previously supported by only
> a private API implementation (much like the situation with OMAP
> DMA) found on the DaVinci family of SoCs.

> Matt Porter (9):
>   ARM: davinci: move private EDMA API to arm/common
>   ARM: edma: remove unused transfer controller handlers

If you are going to be late in re-spinning the entire series in time for
v3.10, then I suggest I queue the first two patches through davinci tree
for v3.10 and then you can work on rest of patches for next (v3.11)
merge window.

Let me know what you think.

>   ARM: edma: add AM33XX support to the private EDMA API
>   dmaengine: edma: enable build for AM33XX
>   dmaengine: edma: Add TI EDMA device tree binding
>   ARM: dts: add AM33XX EDMA support
>   spi: omap2-mcspi: convert to dma_request_slave_channel_compat()
>   spi: omap2-mcspi: add generic DMA request support to the DT binding
>   ARM: dts: add AM33XX SPI DMA support

Thanks,
Sekhar
