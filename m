From: marek@goldelico.com (Marek Belisko)
Date: Mon, 14 Jul 2014 22:20:25 +0200
Subject: [PATCH 2/5] arm: dts: omap3-gta04: Rename gta04.dts to gta04.dtsi and
 add a4 model
In-Reply-To: <1405369228-27197-1-git-send-email-marek@goldelico.com>
References: <1405369228-27197-1-git-send-email-marek@goldelico.com>
Message-ID: <1405369228-27197-3-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is preparation of adding more boards which have common gta04.dtsi

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/Makefile                              |  2 +-
 arch/arm/boot/dts/{omap3-gta04.dts => omap3-gta04.dtsi} |  0
 arch/arm/boot/dts/omap3-gta04a4.dts                     | 13 +++++++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)
 rename arch/arm/boot/dts/{omap3-gta04.dts => omap3-gta04.dtsi} (100%)
 create mode 100644 arch/arm/boot/dts/omap3-gta04a4.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 3547845..9be9edc 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -279,7 +279,7 @@ dtb-$(CONFIG_ARCH_OMAP3) += am3517-craneboard.dtb \
 	omap3-devkit8000.dtb \
 	omap3-evm.dtb \
 	omap3-evm-37xx.dtb \
-	omap3-gta04.dtb \
+	omap3-gta04a4.dtb \
 	omap3-igep0020.dtb \
 	omap3-igep0030.dtb \
 	omap3-ldp.dtb \
diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dtsi
similarity index 100%
rename from arch/arm/boot/dts/omap3-gta04.dts
rename to arch/arm/boot/dts/omap3-gta04.dtsi
diff --git a/arch/arm/boot/dts/omap3-gta04a4.dts b/arch/arm/boot/dts/omap3-gta04a4.dts
new file mode 100644
index 0000000..c918bb1
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-gta04a4.dts
@@ -0,0 +1,13 @@
+/*
+ * Copyright (C) 2014 Marek Belisko <marek@goldelico.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "omap3-gta04.dtsi"
+
+/ {
+	model = "Goldelico GTA04A4";
+};
-- 
1.9.1
