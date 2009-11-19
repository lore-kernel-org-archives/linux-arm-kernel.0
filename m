From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Nov 2009 16:48:15 +0100
Subject: [PATCH 01/12] mx3: Add SSI pins to iomux table
In-Reply-To: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/iomux-mx3.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx3.h b/arch/arm/plat-mxc/include/mach/iomux-mx3.h
index 0dcfb77..8a8fec1 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx3.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx3.h
@@ -700,6 +700,14 @@ enum iomux_pins {
 #define MX31_PIN_RTS1__GPIO2_6		IOMUX_MODE(MX31_PIN_RTS1, IOMUX_CONFIG_GPIO)
 #define MX31_PIN_CTS1__GPIO2_7		IOMUX_MODE(MX31_PIN_CTS1, IOMUX_CONFIG_GPIO)
 #define MX31_PIN_LCS0__GPIO3_23		IOMUX_MODE(MX31_PIN_LCS0, IOMUX_CONFIG_GPIO)
+#define MX31_PIN_STXD4__STXD4		IOMUX_MODE(MX31_PIN_STXD4, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_SRXD4__SRXD4		IOMUX_MODE(MX31_PIN_SRXD4, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_SCK4__SCK4		IOMUX_MODE(MX31_PIN_SCK4, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_SFS4__SFS4		IOMUX_MODE(MX31_PIN_SFS4, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_STXD5__STXD5		IOMUX_MODE(MX31_PIN_STXD5, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_SRXD5__SRXD5		IOMUX_MODE(MX31_PIN_SRXD5, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_SCK5__SCK5		IOMUX_MODE(MX31_PIN_SCK5, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_SFS5__SFS5		IOMUX_MODE(MX31_PIN_SFS5, IOMUX_CONFIG_FUNC)
 
 /*XXX: The SS0, SS1, SS2, SS3 lines of spi3 are multiplexed by cspi2_ss0, cspi2_ss1, cspi1_ss0
  * cspi1_ss1*/
-- 
1.6.5.2
