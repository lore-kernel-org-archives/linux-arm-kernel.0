From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon,  5 Sep 2016 14:17:01 +0100
Subject: [PATCH v9 19/19] dmaengine: kconfig: Remove superfluous '\n'
In-Reply-To: <1473081421-16555-1-git-send-email-peter.griffin@linaro.org>
References: <1473081421-16555-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1473081421-16555-20-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the extra '\n' between kconfig entries.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/dma/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 7c5d946..5b5a341 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -462,7 +462,6 @@ config STM32_DMA
 	  If you have a board based on such a MCU and wish to use DMA say Y or M
 	  here.
 
-
 config S3C24XX_DMAC
 	bool "Samsung S3C24XX DMA support"
 	depends on ARCH_S3C24XX
-- 
1.9.1
