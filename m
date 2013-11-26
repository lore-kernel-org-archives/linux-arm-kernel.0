From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Tue, 26 Nov 2013 16:40:42 +0100
Subject: [PATCH 1/3] ARM: imx27: add pingroups for cspi, sdhc and framebuffer
Message-ID: <1385480444-77808-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/boot/dts/imx27-pingrp.h | 68 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-pingrp.h b/arch/arm/boot/dts/imx27-pingrp.h
index 08d8d18..e61bec2 100644
--- a/arch/arm/boot/dts/imx27-pingrp.h
+++ b/arch/arm/boot/dts/imx27-pingrp.h
@@ -68,4 +68,72 @@
 	MX27_PAD_UART3_CTS__UART3_CTS 0x0 \
 	MX27_PAD_UART3_RTS__UART3_RTS 0x0
 
+#define MX27_CSPI1_PINGRP1 \
+	MX27_PAD_CSPI1_SCLK__CSPI1_SCLK 0x0 \
+	MX27_PAD_CSPI1_MISO__CSPI1_MISO 0x0 \
+	MX27_PAD_CSPI1_MOSI__CSPI1_MOSI 0x0
+
+#define MX27_CSPI2_PINGRP1 \
+	MX27_PAD_CSPI2_SCLK__CSPI2_SCLK 0x0 \
+	MX27_PAD_CSPI2_MISO__CSPI2_MISO 0x0 \
+	MX27_PAD_CSPI2_MOSI__CSPI2_MOSI 0x0
+
+#define MX27_CSPI3_PINGRP1 \
+	MX27_PAD_SD1_CLK__CSPI3_SCLK 0x0 \
+	MX27_PAD_SD1_D0__CSPI3_MISO 0x0 \
+	MX27_PAD_SD1_CMD__CSPI3_MOSI 0x0
+
+#define MX27_SDHC1_PINGRP1 \
+	MX27_PAD_SD1_D0__SD1_D0 \
+	MX27_PAD_SD1_D1__SD1_D1 \
+	MX27_PAD_SD1_D2__SD1_D2 \
+	MX27_PAD_SD1_D3__SD1_D3 \
+	MX27_PAD_SD1_CMD__SD1_CMD \
+	MX27_PAD_SD1_CLK__SD1_CLK
+
+#define MX27_SDHC2_PINGRP1 \
+	MX27_PAD_SD2_D0__SD2_D0 \
+	MX27_PAD_SD2_D1__SD2_D1 \
+	MX27_PAD_SD2_D2__SD2_D2 \
+	MX27_PAD_SD2_D3__SD2_D3 \
+	MX27_PAD_SD2_CMD__SD2_CMD \
+	MX27_PAD_SD2_CLK__SD2_CLK
+
+#define MX27_SDHC3_PINGRP1 \
+	MX27_PAD_SD3_D0__SD3_D0 \
+	MX27_PAD_SD3_D1__SD3_D1 \
+	MX27_PAD_SD3_D2__SD3_D2 \
+	MX27_PAD_SD3_D3__SD3_D3 \
+	MX27_PAD_SD3_CMD__SD3_CMD \
+	MX27_PAD_SD3_CLK__SD3_CLK
+
+#define MX27_FB1_PINGRP1 \
+	MX27_PAD_LSCLK__LSCLK 0x0 \
+	MX27_PAD_LD0__LD0 0x0 \
+	MX27_PAD_LD1__LD1 0x0 \
+	MX27_PAD_LD2__LD2 0x0 \
+	MX27_PAD_LD3__LD3 0x0 \
+	MX27_PAD_LD4__LD4 0x0 \
+	MX27_PAD_LD5__LD5 0x0 \
+	MX27_PAD_LD6__LD6 0x0 \
+	MX27_PAD_LD7__LD7 0x0 \
+	MX27_PAD_LD8__LD8 0x0 \
+	MX27_PAD_LD9__LD9 0x0 \
+	MX27_PAD_LD10__LD10 0x0 \
+	MX27_PAD_LD11__LD11 0x0 \
+	MX27_PAD_LD12__LD12 0x0 \
+	MX27_PAD_LD13__LD13 0x0 \
+	MX27_PAD_LD14__LD14 0x0 \
+	MX27_PAD_LD15__LD15 0x0 \
+	MX27_PAD_LD16__LD16 0x0 \
+	MX27_PAD_LD17__LD17 0x0 \
+	MX27_PAD_REV__REV 0x0 \
+	MX27_PAD_CLS__CLS 0x0 \
+	MX27_PAD_PS__PS 0x0 \
+	MX27_PAD_SPL_SPR__SPL_SPR 0x0 \
+	MX27_PAD_HSYNC__HSYNC 0x0 \
+	MX27_PAD_VSYNC__VSYNC 0x0 \
+	MX27_PAD_CONTRAST__CONTRAST 0x0 \
+	MX27_PAD_OE_ACD__OE_ACD 0x0
+
 #endif /* __DTS_IMX27_PINGRP_H */
-- 
1.8.3.2
