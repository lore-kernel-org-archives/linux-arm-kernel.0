From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Thu, 15 Oct 2009 11:42:55 +0200
Subject: [PATCH 1/6] mx31: various pins used for mx31moboard
In-Reply-To: <1255599780-12948-1-git-send-email-valentin.longchamp@epfl.ch>
References: <1255599780-12948-1-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <1255599780-12948-2-git-send-email-valentin.longchamp@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
---
 arch/arm/plat-mxc/include/mach/iomux-mx3.h |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx3.h b/arch/arm/plat-mxc/include/mach/iomux-mx3.h
index 446f867..0dcfb77 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx3.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx3.h
@@ -623,6 +623,8 @@ enum iomux_pins {
 #define MX31_PIN_GPIO3_0__GPIO3_0	IOMUX_MODE(MX31_PIN_GPIO3_0, IOMUX_CONFIG_GPIO)
 #define MX31_PIN_GPIO3_1__GPIO3_1	IOMUX_MODE(MX31_PIN_GPIO3_1, IOMUX_CONFIG_GPIO)
 #define MX31_PIN_TXD2__GPIO1_28		IOMUX_MODE(MX31_PIN_TXD2, IOMUX_CONFIG_GPIO)
+#define MX31_PIN_CSI_D4__GPIO3_4	IOMUX_MODE(MX31_PIN_CSI_D4, IOMUX_CONFIG_GPIO)
+#define MX31_PIN_CSI_D5__GPIO3_5	IOMUX_MODE(MX31_PIN_CSI_D5, IOMUX_CONFIG_GPIO)
 #define MX31_PIN_USBOTG_DATA0__USBOTG_DATA0    IOMUX_MODE(MX31_PIN_USBOTG_DATA0, IOMUX_CONFIG_FUNC)
 #define MX31_PIN_USBOTG_DATA1__USBOTG_DATA1    IOMUX_MODE(MX31_PIN_USBOTG_DATA1, IOMUX_CONFIG_FUNC)
 #define MX31_PIN_USBOTG_DATA2__USBOTG_DATA2    IOMUX_MODE(MX31_PIN_USBOTG_DATA2, IOMUX_CONFIG_FUNC)
@@ -693,7 +695,11 @@ enum iomux_pins {
 #define MX31_PIN_DCD_DCE1__GPIO2_11	IOMUX_MODE(MX31_PIN_DCD_DCE1, IOMUX_CONFIG_GPIO)
 #define MX31_PIN_STXD5__GPIO1_21       IOMUX_MODE(MX31_PIN_STXD5, IOMUX_CONFIG_GPIO)
 #define MX31_PIN_SRXD5__GPIO1_22       IOMUX_MODE(MX31_PIN_SRXD5, IOMUX_CONFIG_GPIO)
-
+#define MX31_PIN_GPIO1_3__GPIO1_3	IOMUX_MODE(MX31_PIN_GPIO1_3, IOMUX_CONFIG_GPIO)
+#define MX31_PIN_CSPI2_SS1__CSPI3_SS1	IOMUX_MODE(MX31_PIN_CSPI2_SS1, IOMUX_CONFIG_ALT1)
+#define MX31_PIN_RTS1__GPIO2_6		IOMUX_MODE(MX31_PIN_RTS1, IOMUX_CONFIG_GPIO)
+#define MX31_PIN_CTS1__GPIO2_7		IOMUX_MODE(MX31_PIN_CTS1, IOMUX_CONFIG_GPIO)
+#define MX31_PIN_LCS0__GPIO3_23		IOMUX_MODE(MX31_PIN_LCS0, IOMUX_CONFIG_GPIO)
 
 /*XXX: The SS0, SS1, SS2, SS3 lines of spi3 are multiplexed by cspi2_ss0, cspi2_ss1, cspi1_ss0
  * cspi1_ss1*/
-- 
1.6.0.4
