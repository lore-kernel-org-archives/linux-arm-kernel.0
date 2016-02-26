From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri, 26 Feb 2016 15:08:52 +0100
Subject: [PATCH bugfix] ARM: dts: imx51: remove bogus pin definition
Message-ID: <1456495732-3233-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pad DISPB2_SER_RS has no function DISP1_EXT_CLK.
The definition is obviusly a copy/paste error from
MX51_PAD_DISPB2_SER_RS__DISP1_PIN16.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx51-pinfunc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-pinfunc.h b/arch/arm/boot/dts/imx51-pinfunc.h
index 9eb92ab..82eae3c 100644
--- a/arch/arm/boot/dts/imx51-pinfunc.h
+++ b/arch/arm/boot/dts/imx51-pinfunc.h
@@ -536,7 +536,6 @@
 #define MX51_PAD_DISPB2_SER_CLK__DISP1_PIN7		0x2c4 0x6c4 0x000 0x3 0x0
 #define MX51_PAD_DISPB2_SER_CLK__DISPB2_SER_CLK		0x2c4 0x6c4 0x000 0x0 0x0
 #define MX51_PAD_DISPB2_SER_CLK__GPIO3_7		0x2c4 0x6c4 0x990 0x4 0x1
-#define MX51_PAD_DISPB2_SER_RS__DISP1_EXT_CLK		0x2c8 0x6c8 0x000 0x2 0x0
 #define MX51_PAD_DISPB2_SER_RS__DISP1_PIN16		0x2c8 0x6c8 0x000 0x2 0x0
 #define MX51_PAD_DISPB2_SER_RS__DISP1_PIN8		0x2c8 0x6c8 0x000 0x3 0x0
 #define MX51_PAD_DISPB2_SER_RS__DISPB2_SER_RS		0x2c8 0x6c8 0x000 0x0 0x0
-- 
2.1.4
