From: mporter@ti.com (Matt Porter)
Date: Fri, 11 Jan 2013 00:48:40 -0500
Subject: [PATCH v4 04/14] dmaengine: edma: enable build for AM33XX
In-Reply-To: <1357883330-5364-1-git-send-email-mporter@ti.com>
References: <1357883330-5364-1-git-send-email-mporter@ti.com>
Message-ID: <1357883330-5364-5-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable TI EDMA option on OMAP.

Signed-off-by: Matt Porter <mporter@ti.com>
---
 drivers/dma/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index d4c1218..20ef955 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -221,7 +221,7 @@ config SIRF_DMA
 
 config TI_EDMA
 	tristate "TI EDMA support"
-	depends on ARCH_DAVINCI
+	depends on ARCH_DAVINCI || ARCH_OMAP
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	default n
-- 
1.7.9.5
