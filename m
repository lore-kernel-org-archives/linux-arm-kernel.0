From: cory.tusar@pid1solutions.com (Cory Tusar)
Date: Wed, 13 May 2015 23:11:38 -0400
Subject: [PATCH] vf610: dt: Nomenclature fixup for PTC12 pin used in RMII mode.
Message-ID: <1431573098-23809-1-git-send-email-cory.tusar@pid1solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit includes a minor nomenclature fixup for boards based on the
Freescale VF610 SoC and which make use of the alternate "RMII1_RXD1"
functionality for pin PTC12.  This brings the macro name in-line with
both the datasheet and other similar macros.

Signed-off-by: Cory Tusar <cory.tusar@pid1solutions.com>
---
 arch/arm/boot/dts/vf-colibri.dtsi  | 2 +-
 arch/arm/boot/dts/vf610-cosmic.dts | 2 +-
 arch/arm/boot/dts/vf610-pinfunc.h  | 2 +-
 arch/arm/boot/dts/vf610-twr.dts    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index fbef082..68ca125 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -140,7 +140,7 @@
 				VF610_PAD_PTC9__ENET_RMII1_MDC		0x30d2
 				VF610_PAD_PTC10__ENET_RMII1_MDIO	0x30d3
 				VF610_PAD_PTC11__ENET_RMII1_CRS		0x30d1
-				VF610_PAD_PTC12__ENET_RMII_RXD1		0x30d1
+				VF610_PAD_PTC12__ENET_RMII1_RXD1	0x30d1
 				VF610_PAD_PTC13__ENET_RMII1_RXD0	0x30d1
 				VF610_PAD_PTC14__ENET_RMII1_RXER	0x30d1
 				VF610_PAD_PTC15__ENET_RMII1_TXD1	0x30d2
diff --git a/arch/arm/boot/dts/vf610-cosmic.dts b/arch/arm/boot/dts/vf610-cosmic.dts
index fd8758b..5447f25 100644
--- a/arch/arm/boot/dts/vf610-cosmic.dts
+++ b/arch/arm/boot/dts/vf610-cosmic.dts
@@ -68,7 +68,7 @@
 				VF610_PAD_PTC9__ENET_RMII1_MDC		0x30d2
 				VF610_PAD_PTC10__ENET_RMII1_MDIO	0x30d3
 				VF610_PAD_PTC11__ENET_RMII1_CRS		0x30d1
-				VF610_PAD_PTC12__ENET_RMII_RXD1		0x30d1
+				VF610_PAD_PTC12__ENET_RMII1_RXD1	0x30d1
 				VF610_PAD_PTC13__ENET_RMII1_RXD0	0x30d1
 				VF610_PAD_PTC14__ENET_RMII1_RXER	0x30d1
 				VF610_PAD_PTC15__ENET_RMII1_TXD1	0x30d2
diff --git a/arch/arm/boot/dts/vf610-pinfunc.h b/arch/arm/boot/dts/vf610-pinfunc.h
index 1ee681f..fcad713 100644
--- a/arch/arm/boot/dts/vf610-pinfunc.h
+++ b/arch/arm/boot/dts/vf610-pinfunc.h
@@ -369,7 +369,7 @@
 #define VF610_PAD_PTC11__MLB_DATA		0x0E0 0x358 ALT6 0x1
 #define VF610_PAD_PTC11__DEBUG_OUT		0x0E0 0x000 ALT7 0x0
 #define VF610_PAD_PTC12__GPIO_57		0x0E4 0x000 ALT0 0x0
-#define VF610_PAD_PTC12__ENET_RMII_RXD1		0x0E4 0x000 ALT1 0x0
+#define VF610_PAD_PTC12__ENET_RMII1_RXD1	0x0E4 0x000 ALT1 0x0
 #define VF610_PAD_PTC12__ESAI_SDO1		0x0E4 0x318 ALT3 0x1
 #define VF610_PAD_PTC12__SAI2_TX_BCLK		0x0E4 0x370 ALT5 0x1
 #define VF610_PAD_PTC12__DEBUG_OUT3		0x0E4 0x000 ALT7 0x0
diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index f64fddc..375ab23 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -221,7 +221,7 @@
 				VF610_PAD_PTC9__ENET_RMII1_MDC		0x30d2
 				VF610_PAD_PTC10__ENET_RMII1_MDIO	0x30d3
 				VF610_PAD_PTC11__ENET_RMII1_CRS		0x30d1
-				VF610_PAD_PTC12__ENET_RMII_RXD1		0x30d1
+				VF610_PAD_PTC12__ENET_RMII1_RXD1	0x30d1
 				VF610_PAD_PTC13__ENET_RMII1_RXD0	0x30d1
 				VF610_PAD_PTC14__ENET_RMII1_RXER	0x30d1
 				VF610_PAD_PTC15__ENET_RMII1_TXD1	0x30d2
-- 
2.3.6
