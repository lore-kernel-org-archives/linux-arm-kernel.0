From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 20 Jan 2016 11:08:56 +0100
Subject: [PATCHv2 03/16] ARM: dts: imx6ul: move dt-bindings/input/input.h
 include to dtsi file
In-Reply-To: <1453284549-16363-1-git-send-email-LW@KARO-electronics.de>
References: <1452619291-13625-1-git-send-email-LW@KARO-electronics.de>
 <1453284549-16363-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1453284549-16363-4-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx6ul.dtsi references the macro 'KEY_POWER' from
dt-bindings/input/input.h. Thus, move the include statement for this
file from imx6ul-14x14-evk.dts to imx6ul.dtsi itself.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6ul-14x14-evk.dts | 1 -
 arch/arm/boot/dts/imx6ul.dtsi          | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index 6aaa5ec..a6f459a 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -8,7 +8,6 @@
 
 /dts-v1/;
 
-#include <dt-bindings/input/input.h>
 #include "imx6ul.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 7e27d76..e4c3a80 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/clock/imx6ul-clock.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "imx6ul-pinfunc.h"
 #include "skeleton.dtsi"
-- 
2.1.4
