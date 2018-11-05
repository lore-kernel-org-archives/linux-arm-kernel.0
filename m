From: jagan@amarulasolutions.com (Jagan Teki)
Date: Mon,  5 Nov 2018 13:18:42 +0530
Subject: [PATCH v2 3/3] arm64: allwinner: h6: Add OrangePi Lite2 initial
 support
In-Reply-To: <20181105074842.21988-1-jagan@amarulasolutions.com>
References: <20181105074842.21988-1-jagan@amarulasolutions.com>
Message-ID: <20181105074842.21988-3-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@openedev.com>

OrangePi Lite2 is Allwinner H6 based open-source SBC,
which support:
- Allwinner H6 Quad-core 64-bit ARM Cortex-A53
- GPU Mali-T720
- 1GB LPDDR3 RAM
- AXP805 PMIC
- AP6356S Wifi/BT
- USB 2.0, USB 3.0 Host, OTG
- HDMI port
- 5V/2A DC power supply

Signed-off-by: Jagan Teki <jagan@openedev.com>
---
Changes for v2:
- none

 arch/arm64/boot/dts/allwinner/Makefile                |  1 +
 .../boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts   | 11 +++++++++++
 2 files changed, 12 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 8d4f97f279e0..38f4a015637c 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -18,5 +18,6 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-pc2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus2.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-lite2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
new file mode 100644
index 000000000000..e098a2475f2d
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (C) 2018 Jagan Teki <jagan@openedev.com>
+ */
+
+#include "sun50i-h6-orangepi.dtsi"
+
+/ {
+	model = "OrangePi Lite2";
+	compatible = "xunlong,orangepi-lite2", "allwinner,sun50i-h6";
+};
-- 
2.18.0.321.gffc6fa0e3
