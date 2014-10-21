From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Tue, 21 Oct 2014 14:31:43 -0700
Subject: [PATCH] MAINTAINERS: Update Zynq maintainer record
Message-ID: <1413927103-31358-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 - add myself as reviewer for Zynq
 - add entry to cover Zynq clock drivers
 - add entry to cover Xilinx DMA drivers

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a20df9bf8ab0..07eecdddbe8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1543,6 +1543,7 @@ F:	arch/arm/mach-pxa/include/mach/z2.h
 
 ARM/ZYNQ ARCHITECTURE
 M:	Michal Simek <michal.simek@xilinx.com>
+R:	S?ren Brinkmann <soren.brinkmann@xilinx.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 W:	http://wiki.xilinx.com
 T:	git git://git.xilinx.com/linux-xlnx.git
@@ -1552,7 +1553,9 @@ F:	drivers/cpuidle/cpuidle-zynq.c
 F:	drivers/block/xsysace.c
 N:	zynq
 N:	xilinx
+F:	drivers/clk/zynq/
 F:	drivers/clocksource/cadence_ttc_timer.c
+F:	drivers/dma/xilinx/
 F:	drivers/i2c/busses/i2c-cadence.c
 F:	drivers/mmc/host/sdhci-of-arasan.c
 
-- 
2.1.2.1.g5e69ed6
