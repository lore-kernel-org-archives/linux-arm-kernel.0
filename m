From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Tue, 13 Dec 2016 14:40:44 +0100
Subject: [PATCH 2/9] dmaengine: stm32-dma: Fix typo in Kconfig
In-Reply-To: <1481636451-27863-1-git-send-email-cedric.madianga@gmail.com>
References: <1481636451-27863-1-git-send-email-cedric.madianga@gmail.com>
Message-ID: <1481636451-27863-3-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As STM32 DMA driver is only used as buit-in driver, it couldn't be used as
module.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Reviewed-by: Ludovic BARRE <ludovic.barre@st.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 263495d..96da57a 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -458,7 +458,7 @@ config STM32_DMA
 	help
 	  Enable support for the on-chip DMA controller on STMicroelectronics
 	  STM32 MCUs.
-	  If you have a board based on such a MCU and wish to use DMA say Y or M
+	  If you have a board based on such a MCU and wish to use DMA say Y
 	  here.
 
 config S3C24XX_DMAC
-- 
1.9.1
