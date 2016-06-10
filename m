From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 10 Jun 2016 19:19:54 +0100
Subject: [PATCH v2 1/2] ARM: dts: apq8064: rename db600c to SD_600eval
Message-ID: <1465582795-30266-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board has been renamed recently and announced at
https://eragon.einfochips.com/products/sd-600eval.html

So rename this board files so that it reflects actual product in market.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/Makefile                                          | 2 +-
 ...row-db600c-pins.dtsi => qcom-apq8064-arrow-sd-600eval-pins.dtsi} | 0
 ...m-apq8064-arrow-db600c.dts => qcom-apq8064-arrow-sd-600eval.dts} | 6 +++---
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename arch/arm/boot/dts/{qcom-apq8064-arrow-db600c-pins.dtsi => qcom-apq8064-arrow-sd-600eval-pins.dtsi} (100%)
 rename arch/arm/boot/dts/{qcom-apq8064-arrow-db600c.dts => qcom-apq8064-arrow-sd-600eval.dts} (97%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 488a943..66e182c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -573,7 +573,7 @@ dtb-$(CONFIG_ARCH_PRIMA2) += \
 dtb-$(CONFIG_ARCH_OXNAS) += \
 	wd-mbwe.dtb
 dtb-$(CONFIG_ARCH_QCOM) += \
-	qcom-apq8064-arrow-db600c.dtb \
+	qcom-apq8064-arrow-sd-600eval.dtb \
 	qcom-apq8064-cm-qs600.dtb \
 	qcom-apq8064-ifc6410.dtb \
 	qcom-apq8064-sony-xperia-yuga.dtb \
diff --git a/arch/arm/boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi b/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval-pins.dtsi
similarity index 100%
rename from arch/arm/boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi
rename to arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval-pins.dtsi
diff --git a/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts b/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
similarity index 97%
rename from arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
rename to arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
index e01b27e..7df0108 100644
--- a/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
@@ -1,10 +1,10 @@
 #include "qcom-apq8064-v2.0.dtsi"
-#include "qcom-apq8064-arrow-db600c-pins.dtsi"
+#include "qcom-apq8064-arrow-sd-600eval-pins.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 
 / {
-	model = "Arrow Electronics, APQ8064 DB600c";
-	compatible = "arrow,db600c", "qcom,apq8064";
+	model = "Arrow Electronics, APQ8064 SD_600eval";
+	compatible = "arrow,sd_600eval", "qcom,apq8064";
 
 	aliases {
 		serial0 = &gsbi7_serial;
-- 
2.8.3
