From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 27 May 2013 15:33:57 +0530
Subject: [PATCH v7 0/2] dma: imx-dma: OFTree support
In-Reply-To: <1369562001-11494-1-git-send-email-mpa@pengutronix.de>
References: <1369562001-11494-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20130527100357.GA30200@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 26, 2013 at 11:53:19AM +0200, Markus Pargmann wrote:
> Hi,
> 
> this series adds support for the generic DMA DT bindings for imx-dma.
> 
> Regards,
> 
> Markus
> 
> 
> Changes in v7:
>  - rebased onto v3.10-rc2
Applied thanks...

--
~Vinod
> 
> Markus Pargmann (2):
>       dma: imx-dma: Add oftree support
>       DMA: imx-dma: imxdma->dev used uninitialized
> 
>  .../devicetree/bindings/dma/fsl-imx-dma.txt        | 48 ++++++++++++++
>  drivers/dma/imx-dma.c                              | 77 +++++++++++++++++++++-
>  include/linux/platform_data/dma-imx.h              |  6 +-
>  3 files changed, 126 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-dma.txt
> 
