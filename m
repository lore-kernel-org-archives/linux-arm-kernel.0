From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 18 Apr 2013 15:21:36 +0200
Subject: [PATCH RESEND v5 0/2] dma: imx-dma: OFTree support
Message-ID: <1366291298-30004-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series adds support for the generic DMA DT bindings.

Regards,

Markus


Markus Pargmann (2):
      dma: imx-dma: Add oftree support
      DMA: imx-dma: imxdma->dev used uninitialized

 Documentation/devicetree/bindings/dma/fsl-imx-dma.txt | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/imx-dma.c                                 | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/platform_data/dma-imx.h                 |  6 ++----
 3 files changed, 125 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-dma.txt
