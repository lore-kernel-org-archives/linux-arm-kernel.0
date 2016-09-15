From: netz.kernel@gmail.com (Marty Plummer)
Date: Thu, 15 Sep 2016 16:05:03 -0500
Subject: [RFC PATCH v2 3/5] dmaengine: hi3620: Make hi3620 explicit,
 remove wildcard
In-Reply-To: <20160915210505.21878-1-netz.kernel@gmail.com>
References: <20160915210505.21878-1-netz.kernel@gmail.com>
Message-ID: <20160915210505.21878-4-netz.kernel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marty Plummer <netz.kernel@gmail.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 739f797..74bab9d0 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -279,7 +279,7 @@ config INTEL_MIC_X100_DMA
 
 config K3_DMA
 	tristate "Hisilicon K3 DMA support"
-	depends on ARCH_HI3xxx
+	depends on ARCH_HI3620
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.9.3
