From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 14 Nov 2013 14:02:07 -0700
Subject: [PATCH 1/8] ARM: dts: imx: pinfunc: add
 MX6QDL_PAD_SD1_CLK__OSC32K_32K_OUT
In-Reply-To: <1384462934-17390-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1384462934-17390-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1384462934-17390-2-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The solo/duallite reference manual does not mention
this setting, but it works.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 arch/arm/boot/dts/imx6dl-pinfunc.h | 1 +
 arch/arm/boot/dts/imx6q-pinfunc.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-pinfunc.h b/arch/arm/boot/dts/imx6dl-pinfunc.h
index b81a7a4..7499eee 100644
--- a/arch/arm/boot/dts/imx6dl-pinfunc.h
+++ b/arch/arm/boot/dts/imx6dl-pinfunc.h
@@ -950,6 +950,7 @@
 #define MX6QDL_PAD_RGMII_TXC__GPIO6_IO19            0x2d8 0x6c0 0x000 0x5 0x0
 #define MX6QDL_PAD_RGMII_TXC__XTALOSC_REF_CLK_24M   0x2d8 0x6c0 0x000 0x7 0x0
 #define MX6QDL_PAD_SD1_CLK__SD1_CLK                 0x2dc 0x6c4 0x928 0x0 0x1
+#define MX6QDL_PAD_SD1_CLK__OSC32K_32K_OUT          0x2dc 0x6c4 0x000 0x2 0x0
 #define MX6QDL_PAD_SD1_CLK__GPT_CLKIN               0x2dc 0x6c4 0x000 0x3 0x0
 #define MX6QDL_PAD_SD1_CLK__GPIO1_IO20              0x2dc 0x6c4 0x000 0x5 0x0
 #define MX6QDL_PAD_SD1_CMD__SD1_CMD                 0x2e0 0x6c8 0x000 0x0 0x0
diff --git a/arch/arm/boot/dts/imx6q-pinfunc.h b/arch/arm/boot/dts/imx6q-pinfunc.h
index 97ed081..e5834b2 100644
--- a/arch/arm/boot/dts/imx6q-pinfunc.h
+++ b/arch/arm/boot/dts/imx6q-pinfunc.h
@@ -1024,6 +1024,7 @@
 #define MX6QDL_PAD_SD1_DAT2__WDOG1_RESET_B_DEB      0x34c 0x734 0x000 0x6 0x0
 #define MX6QDL_PAD_SD1_CLK__SD1_CLK                 0x350 0x738 0x000 0x0 0x0
 #define MX6QDL_PAD_SD1_CLK__ECSPI5_SCLK             0x350 0x738 0x828 0x1 0x0
+#define MX6QDL_PAD_SD1_CLK__OSC32K_32K_OUT          0x350 0x738 0x000 0x2 0x0
 #define MX6QDL_PAD_SD1_CLK__GPT_CLKIN               0x350 0x738 0x000 0x3 0x0
 #define MX6QDL_PAD_SD1_CLK__GPIO1_IO20              0x350 0x738 0x000 0x5 0x0
 #define MX6QDL_PAD_SD2_CLK__SD2_CLK                 0x354 0x73c 0x000 0x0 0x0
-- 
1.8.1.2
