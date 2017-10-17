From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 17 Oct 2017 11:17:52 +0200
Subject: [PATCHv3 01/12] ARM: dts: imx6-tx6: update model property to match
 current module HW revision
In-Reply-To: <1508231883-12067-1-git-send-email-LW@KARO-electronics.de>
References: <1508230414-8090-1-git-send-email-LW@KARO-electronics.de>
 <1508231883-12067-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1508231883-12067-2-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current TX6Q module HW revision is 3 reflected in the module name
suffix '-1030' (-1130 for LVDS).
Change the model string to prevent confusion about what DTS file to
use for these modules.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6q-tx6q-1010.dts | 4 ++--
 arch/arm/boot/dts/imx6q-tx6q-1110.dts | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-tx6q-1010.dts b/arch/arm/boot/dts/imx6q-tx6q-1010.dts
index e14e6be..17ff7e7 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1010.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1010.dts
@@ -1,5 +1,5 @@
 /*
- * Copyright 2014-2016 Lothar Wa?mann <LW@KARO-electronics.de>
+ * Copyright 2014-2017 Lothar Wa?mann <LW@KARO-electronics.de>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -44,7 +44,7 @@
 #include "imx6qdl-tx6.dtsi"
 
 / {
-	model = "Ka-Ro electronics TX6Q-1010 Module";
+	model = "Ka-Ro electronics TX6Q-1010/-1030 Module";
 	compatible = "karo,imx6q-tx6q", "fsl,imx6q";
 
 	aliases {
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1110.dts b/arch/arm/boot/dts/imx6q-tx6q-1110.dts
index 0433e22..0f5e638 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1110.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1110.dts
@@ -1,5 +1,5 @@
 /*
- * Copyright 2014-2016 Lothar Wa?mann <LW@KARO-electronics.de>
+ * Copyright 2014-2017 Lothar Wa?mann <LW@KARO-electronics.de>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -44,7 +44,7 @@
 #include "imx6qdl-tx6.dtsi"
 
 / {
-	model = "Ka-Ro electronics TX6Q-1110 Module";
+	model = "Ka-Ro electronics TX6Q-1110/-1130 Module";
 	compatible = "karo,imx6q-tx6q", "fsl,imx6q";
 
 	aliases {
-- 
2.1.4
