From: michael.williamson@criticallink.com (Michael Williamson)
Date: Thu,  3 Feb 2011 15:11:59 -0500
Subject: [PATCH] davinci: remove unused DA830_edma_ch enum
Message-ID: <1296763920-4165-1-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DA830_edma_ch enum set is not used.  Remove it.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
---
 arch/arm/mach-davinci/include/mach/edma.h |   36 -----------------------------
 1 files changed, 0 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/edma.h b/arch/arm/mach-davinci/include/mach/edma.h
index dc10ef6..20c77f2 100644
--- a/arch/arm/mach-davinci/include/mach/edma.h
+++ b/arch/arm/mach-davinci/include/mach/edma.h
@@ -151,42 +151,6 @@ struct edmacc_param {
 #define DA830_DMACH2EVENT_MAP1		0x00000000u
 #define DA830_EDMA_ARM_OWN		0x30FFCCFFu
 
-/* DA830 specific EDMA3 Events Information */
-enum DA830_edma_ch {
-	DA830_DMACH_MCASP0_RX,
-	DA830_DMACH_MCASP0_TX,
-	DA830_DMACH_MCASP1_RX,
-	DA830_DMACH_MCASP1_TX,
-	DA830_DMACH_MCASP2_RX,
-	DA830_DMACH_MCASP2_TX,
-	DA830_DMACH_GPIO_BNK0INT,
-	DA830_DMACH_GPIO_BNK1INT,
-	DA830_DMACH_UART0_RX,
-	DA830_DMACH_UART0_TX,
-	DA830_DMACH_TMR64P0_EVTOUT12,
-	DA830_DMACH_TMR64P0_EVTOUT34,
-	DA830_DMACH_UART1_RX,
-	DA830_DMACH_UART1_TX,
-	DA830_DMACH_SPI0_RX,
-	DA830_DMACH_SPI0_TX,
-	DA830_DMACH_MMCSD_RX,
-	DA830_DMACH_MMCSD_TX,
-	DA830_DMACH_SPI1_RX,
-	DA830_DMACH_SPI1_TX,
-	DA830_DMACH_DMAX_EVTOUT6,
-	DA830_DMACH_DMAX_EVTOUT7,
-	DA830_DMACH_GPIO_BNK2INT,
-	DA830_DMACH_GPIO_BNK3INT,
-	DA830_DMACH_I2C0_RX,
-	DA830_DMACH_I2C0_TX,
-	DA830_DMACH_I2C1_RX,
-	DA830_DMACH_I2C1_TX,
-	DA830_DMACH_GPIO_BNK4INT,
-	DA830_DMACH_GPIO_BNK5INT,
-	DA830_DMACH_UART2_RX,
-	DA830_DMACH_UART2_TX
-};
-
 /*ch_status paramater of callback function possible values*/
 #define DMA_COMPLETE 1
 #define DMA_CC_ERROR 2
-- 
1.7.0.4
