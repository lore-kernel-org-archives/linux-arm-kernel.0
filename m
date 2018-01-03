From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Wed, 3 Jan 2018 12:12:07 +0530
Subject: [PATCH v2 0/4] dmaengine: xilinx_dma: Bug fixes
Message-ID: <1514961731-1916-1-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series does the below
--> Fixes sparse warnings in the driver.
--> properly configures the SG mode bit in the driver for cdma.
--> populates dma caps properly.

This patch series got created on top of linux tag 4.15-rc4
i.e slave-dma.git next branch

Kedareswara rao Appana (4):
  dmaengine: xilinx_dma: populate dma caps properly
  dmaengine: xilinx_dma: properly configure the SG mode bit in the
    driver for cdma
  dmaengine: xilinx_dma: Fix warning variable prev set but not used
  dmaengine: xilinx_dma: Free BD consistent memory

 drivers/dma/xilinx/xilinx_dma.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

-- 
2.7.4
