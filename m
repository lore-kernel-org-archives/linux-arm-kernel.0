From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Thu, 7 Dec 2017 10:54:24 +0530
Subject: [PATCH v2 0/4] dmaengine: zynqmp_dma: Bug fixes
Message-ID: <1512624268-13944-1-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series does the below
--> Fixes kernel doc format style issues.
--> Fixes warings in the driver.
--> Fixes issues with overflow interrupt.
--> Fixes race condition in the probe.

This patch series got created on top of the below patch
"dmaengine: zynqmp_dma: Add runtime pm support"

Changes for v2:
--> New patch added "dmaengine: zynqmp_dma: Fix race condition in the probe"
to the series.

Kedareswara rao Appana (4):
  dmaengine: zynqmp_dma: Fix kernel doc-format
  dmaengine: zynqmp_dma: Fix warning variable 'val' set but not used
  dmaengine: zynqmp_dma: Fix issues with overflow interrupt
  dmaengine: zynqmp_dma: Fix race condition in the probe

 drivers/dma/xilinx/zynqmp_dma.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

-- 
2.7.4
