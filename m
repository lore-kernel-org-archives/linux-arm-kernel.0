From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 10 May 2012 12:17:39 +0200
Subject: [PATCH 1/3] dmaengine: at_hdmac: remove some at_dma_slave comments
In-Reply-To: <cover.1336644470.git.nicolas.ferre@atmel.com>
References: <cover.1336644470.git.nicolas.ferre@atmel.com>
Message-ID: <3eb4c8b2943e93fcaf9748d5923aa5a380477d98.1336644470.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These comments were covering removed struct at_dma_slave fields.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/include/mach/at_hdmac.h |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at_hdmac.h b/arch/arm/mach-at91/include/mach/at_hdmac.h
index fff48d1..810a13e 100644
--- a/arch/arm/mach-at91/include/mach/at_hdmac.h
+++ b/arch/arm/mach-at91/include/mach/at_hdmac.h
@@ -26,11 +26,6 @@ struct at_dma_platform_data {
 /**
  * struct at_dma_slave - Controller-specific information about a slave
  * @dma_dev: required DMA master device
- * @tx_reg: physical address of data register used for
- *	memory-to-peripheral transfers
- * @rx_reg: physical address of data register used for
- *	peripheral-to-memory transfers
- * @reg_width: peripheral register width
  * @cfg: Platform-specific initializer for the CFG register
  * @ctrla: Platform-specific initializer for the CTRLA register
  */
-- 
1.7.10
