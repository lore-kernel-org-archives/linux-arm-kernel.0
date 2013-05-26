From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 26 May 2013 11:53:19 +0200
Subject: [PATCH v7 0/2] dma: imx-dma: OFTree support
Message-ID: <1369562001-11494-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series adds support for the generic DMA DT bindings for imx-dma.

Regards,

Markus


Changes in v7:
 - rebased onto v3.10-rc2

Markus Pargmann (2):
      dma: imx-dma: Add oftree support
      DMA: imx-dma: imxdma->dev used uninitialized

 .../devicetree/bindings/dma/fsl-imx-dma.txt        | 48 ++++++++++++++
 drivers/dma/imx-dma.c                              | 77 +++++++++++++++++++++-
 include/linux/platform_data/dma-imx.h              |  6 +-
 3 files changed, 126 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-dma.txt
