From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 13 Feb 2013 11:44:53 +0900
Subject: [PATCH 17/21] ARM: shmobile: sh73a0: Remove I2C function GPIOs
In-Reply-To: <1360723497-23266-1-git-send-email-horms+renesas@verge.net.au>
References: <1360723497-23266-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1360723497-23266-18-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Those GPIOs have been deprecated by the pinctrl API. They are unused and
unneeded, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/sh73a0.h |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/sh73a0.h b/arch/arm/mach-shmobile/include/mach/sh73a0.h
index 54a60d7..8e4e469 100644
--- a/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ b/arch/arm/mach-shmobile/include/mach/sh73a0.h
@@ -115,9 +115,9 @@ enum {
 	GPIO_FN_GPO4, GPIO_FN_STATUS2,
 	GPIO_FN_VINT,
 	GPIO_FN_TCKON,
-	GPIO_FN_XDVFS1, GPIO_FN_PORT27_I2C_SCL2, GPIO_FN_PORT27_I2C_SCL3, \
+	GPIO_FN_XDVFS1,
 	GPIO_FN_MFG0_OUT1, GPIO_FN_PORT27_IROUT,
-	GPIO_FN_XDVFS2, GPIO_FN_PORT28_I2C_SDA2, GPIO_FN_PORT28_I2C_SDA3, \
+	GPIO_FN_XDVFS2,
 	GPIO_FN_PORT28_TPU1TO1,
 	GPIO_FN_SIM_RST, GPIO_FN_PORT29_TPU1TO1,
 	GPIO_FN_SIM_CLK, GPIO_FN_PORT30_VIO_CKOR,
@@ -203,10 +203,8 @@ enum {
 	GPIO_FN_HSI_TX_WAKE, GPIO_FN_BBIF1_TSCK,
 	GPIO_FN_HSI_TX_DATA, GPIO_FN_BBIF1_TSYNC,
 	GPIO_FN_HSI_TX_READY, GPIO_FN_BBIF1_TXD,
-	GPIO_FN_HSI_RX_READY, GPIO_FN_BBIF1_RSCK, GPIO_FN_PORT115_I2C_SCL2, \
-	GPIO_FN_PORT115_I2C_SCL3,
-	GPIO_FN_HSI_RX_WAKE, GPIO_FN_BBIF1_RSYNC, GPIO_FN_PORT116_I2C_SDA2, \
-	GPIO_FN_PORT116_I2C_SDA3,
+	GPIO_FN_HSI_RX_READY, GPIO_FN_BBIF1_RSCK,
+	GPIO_FN_HSI_RX_WAKE, GPIO_FN_BBIF1_RSYNC,
 	GPIO_FN_HSI_RX_FLAG, GPIO_FN_BBIF1_SS1, GPIO_FN_BBIF1_FLOW,
 	GPIO_FN_HSI_TX_FLAG,
 	GPIO_FN_VIO_VD, GPIO_FN_VIO2_VD,
@@ -292,8 +290,8 @@ enum {
 	GPIO_FN_MSIOF1_RXD,
 	GPIO_FN_MSIOF1_RSCK, GPIO_FN_VIO2_CLK2,
 	GPIO_FN_MSIOF1_RSYNC, GPIO_FN_MFG1_IN2, GPIO_FN_VIO2_VD2, \
-	GPIO_FN_MSIOF1_MCK0, GPIO_FN_PORT236_I2C_SDA2,
-	GPIO_FN_MSIOF1_MCK1, GPIO_FN_PORT237_I2C_SCL2,
+	GPIO_FN_MSIOF1_MCK0,
+	GPIO_FN_MSIOF1_MCK1,
 	GPIO_FN_MSIOF1_SS1, GPIO_FN_VIO2_FIELD2,
 	GPIO_FN_MSIOF1_SS2, GPIO_FN_VIO2_HD2,
 	GPIO_FN_PORT241_IRDA_OUT, GPIO_FN_PORT241_IROUT, GPIO_FN_MFG4_OUT1, \
@@ -310,9 +308,9 @@ enum {
 	GPIO_FN_TPU3TO1,
 	GPIO_FN_MFG2_OUT1,
 	GPIO_FN_TPU2TO0,
-	GPIO_FN_PORT248_I2C_SCL3, GPIO_FN_MSIOF2R_TSCK,
+	GPIO_FN_MSIOF2R_TSCK,
 	GPIO_FN_PORT249_IROUT, GPIO_FN_MFG4_IN1, \
-	GPIO_FN_PORT249_I2C_SDA3, GPIO_FN_MSIOF2R_TSYNC,
+	GPIO_FN_MSIOF2R_TSYNC,
 	GPIO_FN_SDHICLK0,
 	GPIO_FN_SDHICD0,
 	GPIO_FN_SDHID0_0,
-- 
1.7.10.4
