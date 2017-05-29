From: jagan@openedev.com (Jagan Teki)
Date: Mon, 29 May 2017 19:30:27 +0000
Subject: [PATCH 2/3] ARM: dts: sunxi: Update model and compatible for bananapi
In-Reply-To: <1496086228-2806-1-git-send-email-jagan@openedev.com>
References: <1496086228-2806-1-git-send-email-jagan@openedev.com>
Message-ID: <1496086228-2806-2-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Since Bananapi brand is owned by BIPAI KEJI(BPI), the previous
Lemaker and Sinovoip no longer use the bananapi brand, hence
Updated the model and compatible for existing bananapi boards
which is denoted same like in binanapi site.

Example: for Bananapi M64 board as

model = "Banana Pi BPI-M64";
compatible = "bananapi,bpi-m64", "allwinner,sun50i-a64";

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Note: Bananapi BPI product site
http://www.banana-pi.org/product.html

 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts          | 4 ++--
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts          | 4 ++--
 arch/arm/boot/dts/sun7i-a20-bananapi-m1.dts               | 4 ++--
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts           | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
index bdfdce8..265f79d 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
@@ -46,8 +46,8 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
-	model = "Sinovoip BPI-M2";
-	compatible = "sinovoip,bpi-m2", "allwinner,sun6i-a31s";
+	model = "Banana PI BPI-M2";
+	compatible = "bananapi,bpi-m2", "allwinner,sun6i-a31s";
 
 	aliases {
 		serial0 = &uart0;
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
index 08e776a..2c87236 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
@@ -49,8 +49,8 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
-	model = "Banana Pi BPI-M1-Plus";
-	compatible = "sinovoip,bpi-m1-plus", "allwinner,sun7i-a20";
+	model = "Banana Pi BPI-M1+";
+	compatible = "bananapi,bpi-m1-plus", "allwinner,sun7i-a20";
 
 	aliases {
 		serial0 = &uart0;
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1.dts
index 8b97b89..3d2597e 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi-m1.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1.dts
@@ -50,8 +50,8 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
-	model = "LeMaker Banana Pi M1";
-	compatible = "lemaker,bananapi", "allwinner,sun7i-a20";
+	model = "Banana Pi BPI-M1";
+	compatible = "bananapi,bpi-m1", "allwinner,sun7i-a20";
 
 	aliases {
 		serial0 = &uart0;
diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index 52acbe1..643b8ec 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -49,7 +49,7 @@
 
 / {
 	model = "Banana Pi BPI-M2-Plus";
-	compatible = "sinovoip,bpi-m2-plus", "allwinner,sun8i-h3";
+	compatible = "bananapi,bpi-m2-plus", "allwinner,sun8i-h3";
 
 	aliases {
 		serial0 = &uart0;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index 6872135..949edba 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -47,8 +47,8 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
-	model = "BananaPi-M64";
-	compatible = "sinovoip,bananapi-m64", "allwinner,sun50i-a64";
+	model = "Banana Pi BPI-M64";
+	compatible = "bananapi,bpi-m64", "allwinner,sun50i-a64";
 
 	aliases {
 		serial0 = &uart0;
-- 
1.9.1
