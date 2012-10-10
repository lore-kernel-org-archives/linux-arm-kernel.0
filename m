From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 10 Oct 2012 16:18:51 +0100
Subject: [PATCH 2/6] ARM: ux500: Add skeleton DTS file for the u9540
In-Reply-To: <1349882335-6786-1-git-send-email-lee.jones@linaro.org>
References: <1349882335-6786-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1349882335-6786-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch sees the creation of a sparse Device Tree file for
ST-Ericsson's latest development board supporting the latest
dual-core Cortex-a9 u9540 SoC.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/u9540.dts |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 arch/arm/boot/dts/u9540.dts

diff --git a/arch/arm/boot/dts/u9540.dts b/arch/arm/boot/dts/u9540.dts
new file mode 100644
index 0000000..0a66f34
--- /dev/null
+++ b/arch/arm/boot/dts/u9540.dts
@@ -0,0 +1,26 @@
+/*
+ * Copyright 2012 ST-Ericsson AB
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "dbx5x0.dtsi"
+
+/ {
+	model = "ST-Ericsson U9540 platform with Device Tree";
+	compatible = "st-ericsson,u9540";
+
+	memory {
+		reg = <0x00000000 0x20000000>;
+	};
+
+	soc-u9500 {
+	};
+
+};
-- 
1.7.9.5
