From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Sep 2012 14:12:31 +0200
Subject: [PATCH 13/32] ARM: ux500: Add skeleton Device Tree for the HREF
 reference board
In-Reply-To: <1348143170-2130-1-git-send-email-lee.jones@linaro.org>
References: <1348143170-2130-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1348143170-2130-14-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First commit applying the new Device Tree for ST-Ericsson's u8500
based hardware reference board.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/hrefv60plus.dts |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 arch/arm/boot/dts/hrefv60plus.dts

diff --git a/arch/arm/boot/dts/hrefv60plus.dts b/arch/arm/boot/dts/hrefv60plus.dts
new file mode 100644
index 0000000..96bf8a3
--- /dev/null
+++ b/arch/arm/boot/dts/hrefv60plus.dts
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
+	model = "ST-Ericsson HREF platform with Device Tree";
+	compatible = "st-ericsson,hrefv60+";
+
+	memory {
+		reg = <0x00000000 0x20000000>;
+	};
+
+	soc-u9500 {
+
+	};
+};
-- 
1.7.9.5
