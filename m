From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 21 Apr 2013 11:08:21 +0200
Subject: [PATCH v6 0/2] dma: imx-dma: OFTree support
Message-ID: <1366535303-31223-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series adds support for the generic DMA DT bindings for imx-dma.

@Arnd and Shawn:
I added your Reviewed-by tags again. Please let me know if they do not include
the last style fixes on the xlate function.

Thanks,

Markus


Markus Pargmann (2):
      dma: imx-dma: Add oftree support
      DMA: imx-dma: imxdma->dev used uninitialized

 Documentation/devicetree/bindings/dma/fsl-imx-dma.txt | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/imx-dma.c                                 | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/platform_data/dma-imx.h                 |  6 ++----
 3 files changed, 126 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-dma.txt
