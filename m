From: marex@denx.de (Marek Vasut)
Date: Fri, 28 Feb 2014 12:58:41 +0100
Subject: [PATCH] ARM: dts: imx: Add alias for ethernet controller
Message-ID: <1393588721-8598-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add alias for FEC ethernet on i.MX to allow bootloaders (like U-Boot)
patch-in the MAC address for FEC using this alias.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx25.dtsi   | 1 +
 arch/arm/boot/dts/imx27.dtsi   | 1 +
 arch/arm/boot/dts/imx35.dtsi   | 1 +
 arch/arm/boot/dts/imx50.dtsi   | 1 +
 arch/arm/boot/dts/imx51.dtsi   | 1 +
 arch/arm/boot/dts/imx53.dtsi   | 1 +
 arch/arm/boot/dts/imx6qdl.dtsi | 1 +
 arch/arm/boot/dts/imx6sl.dtsi  | 1 +
 8 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 32f760e..77bb743 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -14,6 +14,7 @@
 
 / {
 	aliases {
+		ethernet0 = &fec;
 		gpio0 = &gpio1;
 		gpio1 = &gpio2;
 		gpio2 = &gpio3;
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 6279e0b..83a8247 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -16,6 +16,7 @@
 
 / {
 	aliases {
+		ethernet0 = &fec;
 		gpio0 = &gpio1;
 		gpio1 = &gpio2;
 		gpio2 = &gpio3;
diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index 88b218f..e59ccb4 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -13,6 +13,7 @@
 
 / {
 	aliases {
+		ethernet0 = &fec;
 		gpio0 = &gpio1;
 		gpio1 = &gpio2;
 		gpio2 = &gpio3;
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index 0c75fe3..c249064 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -17,6 +17,7 @@
 
 / {
 	aliases {
+		ethernet0 = &fec;
 		gpio0 = &gpio1;
 		gpio1 = &gpio2;
 		gpio2 = &gpio3;
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index e4b07d1..e508e6f 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -19,6 +19,7 @@
 
 / {
 	aliases {
+		ethernet0 = &fec;
 		gpio0 = &gpio1;
 		gpio1 = &gpio2;
 		gpio2 = &gpio3;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 80615df..5f382ea 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -18,6 +18,7 @@
 
 / {
 	aliases {
+		ethernet0 = &fec;
 		gpio0 = &gpio1;
 		gpio1 = &gpio2;
 		gpio2 = &gpio3;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index a2d5c49..d63df59 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -14,6 +14,7 @@
 
 / {
 	aliases {
+		ethernet0 = &fec;
 		can0 = &can1;
 		can1 = &can2;
 		gpio0 = &gpio1;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 3cb4941..6477447 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -14,6 +14,7 @@
 
 / {
 	aliases {
+		ethernet0 = &fec;
 		gpio0 = &gpio1;
 		gpio1 = &gpio2;
 		gpio2 = &gpio3;
-- 
1.8.5.2
