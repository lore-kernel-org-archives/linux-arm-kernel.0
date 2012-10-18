From: mporter@ti.com (Matt Porter)
Date: Thu, 18 Oct 2012 09:26:45 -0400
Subject: [RFC PATCH v3 06/16] dmaengine: edma: enable build for AM33XX
In-Reply-To: <1350566815-409-1-git-send-email-mporter@ti.com>
References: <1350566815-409-1-git-send-email-mporter@ti.com>
Message-ID: <1350566815-409-7-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable TI EDMA option on OMAP.

Signed-off-by: Matt Porter <mporter@ti.com>
---
 drivers/dma/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 677cd6e..eaea1c2 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -210,7 +210,7 @@ config SIRF_DMA
 
 config TI_EDMA
 	tristate "TI EDMA support"
-	depends on ARCH_DAVINCI
+	depends on ARCH_DAVINCI || ARCH_OMAP
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	default n
-- 
1.7.9.5
