From: sr@denx.de (Stefan Roese)
Date: Mon, 26 Nov 2012 15:46:12 +0100
Subject: [PATCH] ARM: sunxi: Add missing sun4i.dtsi file
Message-ID: <1353941172-26121-1-git-send-email-sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch f055f1f6 [ARM: sunxi: Add sun4i and cubieboard support] missed
this sun4i.dtsi include file. This patch finally brings it upstream
enabling support for sun4i boards.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
---
Arnd, I missed adding this include dtsi file in my last
cubieboard/sun4i support patch. Please add this patch
to your v3.8 branch.

Thanks,
Stefan

 arch/arm/boot/dts/sun4i.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun4i.dtsi

diff --git a/arch/arm/boot/dts/sun4i.dtsi b/arch/arm/boot/dts/sun4i.dtsi
new file mode 100644
index 0000000..e61fdd4
--- /dev/null
+++ b/arch/arm/boot/dts/sun4i.dtsi
@@ -0,0 +1,19 @@
+/*
+ * Copyright 2012 Stefan Roese
+ * Stefan Roese <sr@denx.de>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/include/ "sunxi.dtsi"
+
+/ {
+	memory {
+		reg = <0x40000000 0x80000000>;
+	};
+};
-- 
1.8.0
