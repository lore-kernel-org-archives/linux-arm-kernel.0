From: festevam@gmail.com (Fabio Estevam)
Date: Sun,  7 Jun 2015 20:41:07 -0300
Subject: [PATCH] ARM: dts: imx6sl-warp: Add the SD2_RESET pin
Message-ID: <1433720467-9070-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

imx6sl-warp has SD2_RESET pin connected to the eMMC reset line,
so add this pin to the usdhc2 group.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6sl-warp.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sl-warp.dts b/arch/arm/boot/dts/imx6sl-warp.dts
index 0da906b..401a6b3 100644
--- a/arch/arm/boot/dts/imx6sl-warp.dts
+++ b/arch/arm/boot/dts/imx6sl-warp.dts
@@ -158,6 +158,7 @@
 				MX6SL_PAD_SD2_DAT5__SD2_DATA5		0x417059
 				MX6SL_PAD_SD2_DAT6__SD2_DATA6		0x417059
 				MX6SL_PAD_SD2_DAT7__SD2_DATA7		0x417059
+				MX6SL_PAD_SD2_RST__SD2_RESET		0x417059
 			>;
 		};
 
@@ -173,6 +174,7 @@
 				MX6SL_PAD_SD2_DAT5__SD2_DATA5		0x4170b9
 				MX6SL_PAD_SD2_DAT6__SD2_DATA6		0x4170b9
 				MX6SL_PAD_SD2_DAT7__SD2_DATA7		0x4170b9
+				MX6SL_PAD_SD2_RST__SD2_RESET		0x4170b9
 			>;
 		};
 
@@ -188,6 +190,7 @@
 				MX6SL_PAD_SD2_DAT5__SD2_DATA5		0x4170f9
 				MX6SL_PAD_SD2_DAT6__SD2_DATA6		0x4170f9
 				MX6SL_PAD_SD2_DAT7__SD2_DATA7		0x4170f9
+				MX6SL_PAD_SD2_RST__SD2_RESET		0x4170f9
 			>;
 		};
 
-- 
1.9.1
