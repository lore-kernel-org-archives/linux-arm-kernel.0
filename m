From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 24 Apr 2013 22:04:31 +0800
Subject: [PATCH 0/2] dma: imx-sdma: add generic DMA device tree bindings
 support
Message-ID: <1366812273-10833-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series adds add generic DMA device tree bindings support for
imx-sdma.  The legacy DMA requesting support is still there and will
be removed after all clients get converted to generic DMA DT helper.

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
