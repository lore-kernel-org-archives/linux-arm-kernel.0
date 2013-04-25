From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 25 Apr 2013 22:43:26 +0800
Subject: [PATCH v2 0/2] dma: imx-sdma: add generic DMA device tree bindings
 support
Message-ID: <1366901008-7593-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
 * Fix the example typo in bindings doc.  Thanks to Fabio.

Shawn Guo (2):
  dma: imx: change enum definitions to macros
  dma: imx-sdma: move to generic device tree bindings

 .../devicetree/bindings/dma/fsl-imx-sdma.txt       |   22 ++++++++++
 drivers/dma/imx-sdma.c                             |   44 +++++++++++++++++++-
 include/dt-bindings/dma/imx.h                      |   29 +++++++++++++
 include/linux/platform_data/dma-imx.h              |   37 +---------------
 4 files changed, 95 insertions(+), 37 deletions(-)
 create mode 100644 include/dt-bindings/dma/imx.h

-- 
1.7.9.5
