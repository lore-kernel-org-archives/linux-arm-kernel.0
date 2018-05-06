From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun,  6 May 2018 15:43:46 +0200
Subject: [PATCH 1/7] ARM: dts: gemini: Fix "debounce-interval" property
 misspelling
In-Reply-To: <20180506134352.2637-1-linus.walleij@linaro.org>
References: <20180506134352.2637-1-linus.walleij@linaro.org>
Message-ID: <20180506134352.2637-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

"debounce_interval" was never supported.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/gemini-dlink-dir-685.dts | 4 ++--
 arch/arm/boot/dts/gemini-dlink-dns-313.dts | 2 +-
 arch/arm/boot/dts/gemini-nas4220b.dts      | 4 ++--
 arch/arm/boot/dts/gemini-rut1xx.dts        | 2 +-
 arch/arm/boot/dts/gemini-sq201.dts         | 2 +-
 arch/arm/boot/dts/gemini-wbd111.dts        | 2 +-
 arch/arm/boot/dts/gemini-wbd222.dts        | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/gemini-dlink-dir-685.dts b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
index cadde92bc6b5..369c80076a61 100644
--- a/arch/arm/boot/dts/gemini-dlink-dir-685.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
@@ -28,7 +28,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		button-esc {
-			debounce_interval = <50>;
+			debounce-interval = <50>;
 			wakeup-source;
 			linux,code = <KEY_ESC>;
 			label = "reset";
@@ -36,7 +36,7 @@
 			gpios = <&gpio0 8 GPIO_ACTIVE_LOW>;
 		};
 		button-eject {
-			debounce_interval = <50>;
+			debounce-interval = <50>;
 			wakeup-source;
 			linux,code = <KEY_EJECTCD>;
 			label = "unmount";
diff --git a/arch/arm/boot/dts/gemini-dlink-dns-313.dts b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
index 403364a7aab9..55b294f1675c 100644
--- a/arch/arm/boot/dts/gemini-dlink-dns-313.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
@@ -34,7 +34,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		button-esc {
-			debounce_interval = <50>;
+			debounce-interval = <50>;
 			wakeup-source;
 			linux,code = <KEY_ESC>;
 			label = "reset";
diff --git a/arch/arm/boot/dts/gemini-nas4220b.dts b/arch/arm/boot/dts/gemini-nas4220b.dts
index 4785fbcc41ed..465c26b53212 100644
--- a/arch/arm/boot/dts/gemini-nas4220b.dts
+++ b/arch/arm/boot/dts/gemini-nas4220b.dts
@@ -30,7 +30,7 @@
 		#size-cells = <0>;
 
 		button at 29 {
-			debounce_interval = <50>;
+			debounce-interval = <50>;
 			wakeup-source;
 			linux,code = <KEY_SETUP>;
 			label = "Backup button";
@@ -38,7 +38,7 @@
 			gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
 		};
 		button at 31 {
-			debounce_interval = <50>;
+			debounce-interval = <50>;
 			wakeup-source;
 			linux,code = <KEY_RESTART>;
 			label = "Softreset button";
diff --git a/arch/arm/boot/dts/gemini-rut1xx.dts b/arch/arm/boot/dts/gemini-rut1xx.dts
index 15f20178642c..a2f14ee37599 100644
--- a/arch/arm/boot/dts/gemini-rut1xx.dts
+++ b/arch/arm/boot/dts/gemini-rut1xx.dts
@@ -30,7 +30,7 @@
 		#size-cells = <0>;
 
 		button at 28 {
-			debounce_interval = <50>;
+			debounce-interval = <50>;
 			wakeup-source;
 			linux,code = <KEY_SETUP>;
 			label = "Reset to defaults";
diff --git a/arch/arm/boot/dts/gemini-sq201.dts b/arch/arm/boot/dts/gemini-sq201.dts
index 63c02ca9513c..229c0267617a 100644
--- a/arch/arm/boot/dts/gemini-sq201.dts
+++ b/arch/arm/boot/dts/gemini-sq201.dts
@@ -30,7 +30,7 @@
 		#size-cells = <0>;
 
 		button at 18 {
-			debounce_interval = <50>;
+			debounce-interval = <50>;
 			wakeup-source;
 			linux,code = <KEY_SETUP>;
 			label = "factory reset";
diff --git a/arch/arm/boot/dts/gemini-wbd111.dts b/arch/arm/boot/dts/gemini-wbd111.dts
index b4ec9ad85d72..b31a9189083f 100644
--- a/arch/arm/boot/dts/gemini-wbd111.dts
+++ b/arch/arm/boot/dts/gemini-wbd111.dts
@@ -30,7 +30,7 @@
 		#size-cells = <0>;
 
 		button at 5 {
-			debounce_interval = <50>;
+			debounce-interval = <50>;
 			wakeup-source;
 			linux,code = <KEY_SETUP>;
 			label = "reset";
diff --git a/arch/arm/boot/dts/gemini-wbd222.dts b/arch/arm/boot/dts/gemini-wbd222.dts
index 6d25bcc046e7..0be867fbfc69 100644
--- a/arch/arm/boot/dts/gemini-wbd222.dts
+++ b/arch/arm/boot/dts/gemini-wbd222.dts
@@ -30,7 +30,7 @@
 		#size-cells = <0>;
 
 		button at 5 {
-			debounce_interval = <50>;
+			debounce-interval = <50>;
 			wakeup-source;
 			linux,code = <KEY_SETUP>;
 			label = "reset";
-- 
2.17.0
