From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Thu, 21 Dec 2017 15:41:34 +0530
Subject: [LINUX PATCH 0/4] dmaengine: xilinx_dma: Bug fixes
Message-ID: <1513851098-15787-1-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series does the below
--> Fixes sparse warnings in the driver.
--> Fixes race conditions in the driver for cdma.
--> Fixes issues with the dma_get_slave_caps() API failures.

This patch series got created on top of below commit 
in the slave-dma.git topic/xilinx branch.
"dmaengine: xilinx_dma: Fix typos"

Kedareswara rao Appana (4):
  dmaengine: xilinx_dma: Fix dma_get_slave_caps() API failures
  dmaengine: xilinx_dma: Fix race condition in the driver for cdma
  dmaengine: xilinx_dma: Fix compilation warning
  dmaengine: xilinx_dma: Free BD consistent memory

 drivers/dma/xilinx/xilinx_dma.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

-- 
2.7.4
