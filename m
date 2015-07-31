From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat,  1 Aug 2015 00:58:23 +0200
Subject: [PATCH 2/9] ARM: at91/dt: include lcd dtsi in at91sam9x5 dtsis
In-Reply-To: <1438383510-10521-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438383510-10521-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438383510-10521-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris BREZILLON <boris.brezillon@free-electrons.com>

Actually make use of at91sam9x5_lcd.dtsi in the relevant SoC dtsis.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9g15.dtsi | 1 +
 arch/arm/boot/dts/at91sam9g35.dtsi | 1 +
 arch/arm/boot/dts/at91sam9x35.dtsi | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9g15.dtsi b/arch/arm/boot/dts/at91sam9g15.dtsi
index cfd7044616d7..27de7dc0f0e0 100644
--- a/arch/arm/boot/dts/at91sam9g15.dtsi
+++ b/arch/arm/boot/dts/at91sam9g15.dtsi
@@ -7,6 +7,7 @@
  */
 
 #include "at91sam9x5.dtsi"
+#include "at91sam9x5_lcd.dtsi"
 
 / {
 	model = "Atmel AT91SAM9G15 SoC";
diff --git a/arch/arm/boot/dts/at91sam9g35.dtsi b/arch/arm/boot/dts/at91sam9g35.dtsi
index e35c2fcf8298..ff4115886f97 100644
--- a/arch/arm/boot/dts/at91sam9g35.dtsi
+++ b/arch/arm/boot/dts/at91sam9g35.dtsi
@@ -7,6 +7,7 @@
  */
 
 #include "at91sam9x5.dtsi"
+#include "at91sam9x5_lcd.dtsi"
 #include "at91sam9x5_macb0.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/at91sam9x35.dtsi b/arch/arm/boot/dts/at91sam9x35.dtsi
index 499cdc81f4c0..d9054e8167b7 100644
--- a/arch/arm/boot/dts/at91sam9x35.dtsi
+++ b/arch/arm/boot/dts/at91sam9x35.dtsi
@@ -7,6 +7,7 @@
  */
 
 #include "at91sam9x5.dtsi"
+#include "at91sam9x5_lcd.dtsi"
 #include "at91sam9x5_macb0.dtsi"
 #include "at91sam9x5_can.dtsi"
 
-- 
2.1.4
