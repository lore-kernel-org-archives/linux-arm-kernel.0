From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 1 Dec 2017 09:24:50 +0800
Subject: [PATCH v4 2/4] clk: meson-axg: add clocks dt-bindings required header
In-Reply-To: <20171201012452.27086-1-yixun.lan@amlogic.com>
References: <20171201012452.27086-1-yixun.lan@amlogic.com>
Message-ID: <20171201012452.27086-3-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qiufang Dai <qiufang.dai@amlogic.com>

Add the required header for the clocks ID dt-bindings
exported from various subsystem in the Meson-AXG SoC.

Signed-off-by: Qiufang Dai <qiufang.dai@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 include/dt-bindings/clock/axg-clkc.h | 71 ++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 include/dt-bindings/clock/axg-clkc.h

diff --git a/include/dt-bindings/clock/axg-clkc.h b/include/dt-bindings/clock/axg-clkc.h
new file mode 100644
index 000000000000..941ac70e7f30
--- /dev/null
+++ b/include/dt-bindings/clock/axg-clkc.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Meson-AXG clock tree IDs
+ *
+ * Copyright (c) 2017 Amlogic, Inc. All rights reserved.
+ */
+
+#ifndef __AXG_CLKC_H
+#define __AXG_CLKC_H
+
+#define CLKID_SYS_PLL				0
+#define CLKID_FIXED_PLL				1
+#define CLKID_FCLK_DIV2				2
+#define CLKID_FCLK_DIV3				3
+#define CLKID_FCLK_DIV4				4
+#define CLKID_FCLK_DIV5				5
+#define CLKID_FCLK_DIV7				6
+#define CLKID_GP0_PLL				7
+#define CLKID_CLK81				10
+#define CLKID_MPLL0				11
+#define CLKID_MPLL1				12
+#define CLKID_MPLL2				13
+#define CLKID_MPLL3				14
+#define CLKID_DDR				15
+#define CLKID_AUDIO_LOCKER			16
+#define CLKID_MIPI_DSI_HOST			17
+#define CLKID_ISA				18
+#define CLKID_PL301				19
+#define CLKID_PERIPHS				20
+#define CLKID_SPICC0				21
+#define CLKID_I2C				22
+#define CLKID_RNG0				23
+#define CLKID_UART0				24
+#define CLKID_MIPI_DSI_PHY			25
+#define CLKID_SPICC1				26
+#define CLKID_PCIE_A				27
+#define CLKID_PCIE_B				28
+#define CLKID_HIU_IFACE				29
+#define CLKID_ASSIST_MISC			30
+#define CLKID_SD_EMMC_B				31
+#define CLKID_SD_EMMC_C				32
+#define CLKID_DMA				33
+#define CLKID_SPI				34
+#define CLKID_AUDIO				35
+#define CLKID_ETH				36
+#define CLKID_UART1				37
+#define CLKID_G2D				38
+#define CLKID_USB0				39
+#define CLKID_USB1				40
+#define CLKID_RESET				41
+#define CLKID_USB				42
+#define CLKID_AHB_ARB0				43
+#define CLKID_EFUSE				44
+#define CLKID_BOOT_ROM				45
+#define CLKID_AHB_DATA_BUS			46
+#define CLKID_AHB_CTRL_BUS			47
+#define CLKID_USB1_DDR_BRIDGE			48
+#define CLKID_USB0_DDR_BRIDGE			49
+#define CLKID_MMC_PCLK				50
+#define CLKID_VPU_INTR				51
+#define CLKID_SEC_AHB_AHB3_BRIDGE		52
+#define CLKID_GIC				53
+#define CLKID_AO_MEDIA_CPU			54
+#define CLKID_AO_AHB_SRAM			55
+#define CLKID_AO_AHB_BUS			56
+#define CLKID_AO_IFACE				57
+#define CLKID_AO_I2C				58
+#define CLKID_SD_EMMC_B_CLK0			59
+#define CLKID_SD_EMMC_C_CLK0			60
+
+#endif /* __AXG_CLKC_H */
-- 
2.15.0
