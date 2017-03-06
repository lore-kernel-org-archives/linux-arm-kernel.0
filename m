From: Ramiro.Oliveira@synopsys.com (Ramiro Oliveira)
Date: Mon,  6 Mar 2017 12:27:33 +0000
Subject: [PATCH] dma: xilinx: Make Xilinx VDMA support ARC
Message-ID: <ec057c7b16c414a1cf9a9eba87c33f8bcf9f01f9.1488803103.git.roliveir@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add option in Kconfig to use Xilinx VDMA in ARC processors.

Signed-off-by: Ramiro Oliveira <roliveir@synopsys.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 263495d0adbd..b6b6c0581ad7 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -546,7 +546,7 @@ config XGENE_DMA
 
 config XILINX_DMA
 	tristate "Xilinx AXI DMAS Engine"
-	depends on (ARCH_ZYNQ || MICROBLAZE || ARM64)
+	depends on (ARCH_ZYNQ || MICROBLAZE || ARM64|| ARC)
 	select DMA_ENGINE
 	help
 	  Enable support for Xilinx AXI VDMA Soft IP.
-- 
2.11.0
