From: akurz@blala.de (Alexander Kurz)
Date: Sun, 24 Jun 2018 05:59:29 +0000
Subject: [PATCH] ARM: dts: imx50: fix KPP pin definition typos
Message-ID: <20180624055929.10011-1-akurz@blala.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

iMX50 pin mux options for pads KEY_COL2 and KEY_COL3 allow muxing the same
KEY_COL instances as the pad name. Fix typos shifting KEY_COL instances.

Signed-off-by: Alexander Kurz <akurz@blala.de>
---
 arch/arm/boot/dts/imx50-pinfunc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx50-pinfunc.h b/arch/arm/boot/dts/imx50-pinfunc.h
index 97e6e7f4ebdd..43863347362e 100644
--- a/arch/arm/boot/dts/imx50-pinfunc.h
+++ b/arch/arm/boot/dts/imx50-pinfunc.h
@@ -34,7 +34,7 @@
 #define MX50_PAD_KEY_ROW1__EIM_NANDF_CEN_1			0x02c 0x2d8 0x000 0x2 0x0
 #define MX50_PAD_KEY_ROW1__CTI_TRIGOUT_ACK7			0x02c 0x2d8 0x000 0x6 0x0
 #define MX50_PAD_KEY_ROW1__USBPHY1_RXERROR			0x02c 0x2d8 0x000 0x7 0x0
-#define MX50_PAD_KEY_COL2__KPP_COL_1				0x030 0x2dc 0x000 0x0 0x0
+#define MX50_PAD_KEY_COL2__KPP_COL_2				0x030 0x2dc 0x000 0x0 0x0
 #define MX50_PAD_KEY_COL2__GPIO4_4				0x030 0x2dc 0x000 0x1 0x0
 #define MX50_PAD_KEY_COL2__EIM_NANDF_CEN_2			0x030 0x2dc 0x000 0x2 0x0
 #define MX50_PAD_KEY_COL2__CTI_TRIGOUT6				0x030 0x2dc 0x000 0x6 0x0
@@ -44,7 +44,7 @@
 #define MX50_PAD_KEY_ROW2__EIM_NANDF_CEN_3			0x034 0x2e0 0x000 0x2 0x0
 #define MX50_PAD_KEY_ROW2__CTI_TRIGOUT7				0x034 0x2e0 0x000 0x6 0x0
 #define MX50_PAD_KEY_ROW2__USBPHY1_LINESTATE_0			0x034 0x2e0 0x000 0x7 0x0
-#define MX50_PAD_KEY_COL3__KPP_COL_2				0x038 0x2e4 0x000 0x0 0x0
+#define MX50_PAD_KEY_COL3__KPP_COL_3				0x038 0x2e4 0x000 0x0 0x0
 #define MX50_PAD_KEY_COL3__GPIO4_6				0x038 0x2e4 0x000 0x1 0x0
 #define MX50_PAD_KEY_COL3__EIM_NANDF_READY0			0x038 0x2e4 0x7b4 0x2 0x0
 #define MX50_PAD_KEY_COL3__SDMA_EXT_EVENT_0			0x038 0x2e4 0x7b8 0x6 0x0
-- 
2.11.0
