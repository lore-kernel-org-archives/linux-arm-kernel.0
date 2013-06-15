From: joelagnel@ti.com (Joel A Fernandes)
Date: Fri, 14 Jun 2013 21:32:46 -0500
Subject: [PATCH v10 4/8] dmaengine: edma: enable build for AM33XX
In-Reply-To: <1371263570-9323-1-git-send-email-joelagnel@ti.com>
References: <1371263570-9323-1-git-send-email-joelagnel@ti.com>
Message-ID: <1371263570-9323-4-git-send-email-joelagnel@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matt Porter <mporter@ti.com>

Enable TI EDMA option on OMAP.

Signed-off-by: Matt Porter <mporter@ti.com>
Signed-off-by: Joel A Fernandes <joelagnel@ti.com>
---
 drivers/dma/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index e992489..3215a3c 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -213,7 +213,7 @@ config SIRF_DMA
 
 config TI_EDMA
 	tristate "TI EDMA support"
-	depends on ARCH_DAVINCI
+	depends on ARCH_DAVINCI || ARCH_OMAP
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	default n
-- 
1.7.9.5
