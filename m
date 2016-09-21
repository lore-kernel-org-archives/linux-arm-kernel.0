From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 21 Sep 2016 13:26:35 +0300
Subject: [PATCH v2 7/9] dmaengine: edma: enable COMPILE_TEST
In-Reply-To: <20160921102637.24845-1-peter.ujfalusi@ti.com>
References: <20160921102637.24845-1-peter.ujfalusi@ti.com>
Message-ID: <20160921102637.24845-8-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To get more coverage, enable COMPILE_TEST for this driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index fe2dbb811e19..4348249b943a 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -515,7 +515,7 @@ config TI_DMA_CROSSBAR
 
 config TI_EDMA
 	bool "TI EDMA support"
-	depends on ARCH_DAVINCI || ARCH_OMAP || ARCH_KEYSTONE
+	depends on ARCH_DAVINCI || ARCH_OMAP || ARCH_KEYSTONE || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	select TI_DMA_CROSSBAR if ARCH_OMAP
-- 
2.10.0
