From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 15 May 2013 16:03:01 +0200
Subject: [PATCH 1/5] ARM: at91: dt: use #include for all device trees
In-Reply-To: <20130515135821.GG22508@game.jcrosoft.org>
References: <20130515135821.GG22508@game.jcrosoft.org>
Message-ID: <1368626585-24425-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

to prepare the switch to the macro.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/aks-cdu.dts               |    2 +-
 arch/arm/boot/dts/animeo_ip.dts             |    2 +-
 arch/arm/boot/dts/at91-ariag25.dts          |    2 +-
 arch/arm/boot/dts/at91rm9200.dtsi           |    2 +-
 arch/arm/boot/dts/at91rm9200ek.dts          |    2 +-
 arch/arm/boot/dts/at91sam9260.dtsi          |    2 +-
 arch/arm/boot/dts/at91sam9263.dtsi          |    2 +-
 arch/arm/boot/dts/at91sam9263ek.dts         |    2 +-
 arch/arm/boot/dts/at91sam9g15.dtsi          |    2 +-
 arch/arm/boot/dts/at91sam9g15ek.dts         |    4 ++--
 arch/arm/boot/dts/at91sam9g20.dtsi          |    2 +-
 arch/arm/boot/dts/at91sam9g20ek.dts         |    2 +-
 arch/arm/boot/dts/at91sam9g20ek_2mmc.dts    |    2 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |    2 +-
 arch/arm/boot/dts/at91sam9g25.dtsi          |    2 +-
 arch/arm/boot/dts/at91sam9g25ek.dts         |    4 ++--
 arch/arm/boot/dts/at91sam9g35.dtsi          |    2 +-
 arch/arm/boot/dts/at91sam9g35ek.dts         |    4 ++--
 arch/arm/boot/dts/at91sam9g45.dtsi          |    2 +-
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |    2 +-
 arch/arm/boot/dts/at91sam9n12.dtsi          |    2 +-
 arch/arm/boot/dts/at91sam9n12ek.dts         |    2 +-
 arch/arm/boot/dts/at91sam9x25.dtsi          |    2 +-
 arch/arm/boot/dts/at91sam9x25ek.dts         |    4 ++--
 arch/arm/boot/dts/at91sam9x35.dtsi          |    2 +-
 arch/arm/boot/dts/at91sam9x35ek.dts         |    4 ++--
 arch/arm/boot/dts/at91sam9x5.dtsi           |    2 +-
 arch/arm/boot/dts/at91sam9x5ek.dtsi         |    2 +-
 arch/arm/boot/dts/ethernut5.dts             |    2 +-
 arch/arm/boot/dts/evk-pro3.dts              |    4 ++--
 arch/arm/boot/dts/ge863-pro3.dtsi           |    2 +-
 arch/arm/boot/dts/kizbox.dts                |    4 ++--
 arch/arm/boot/dts/mpa1600.dts               |    2 +-
 arch/arm/boot/dts/pm9g45.dts                |    2 +-
 arch/arm/boot/dts/sama5d3.dtsi              |    2 +-
 arch/arm/boot/dts/sama5d31ek.dts            |    4 ++--
 arch/arm/boot/dts/sama5d33ek.dts            |    4 ++--
 arch/arm/boot/dts/sama5d34ek.dts            |    4 ++--
 arch/arm/boot/dts/sama5d35ek.dts            |    2 +-
 arch/arm/boot/dts/sama5d3xcm.dtsi           |    2 +-
 arch/arm/boot/dts/sama5d3xmb.dtsi           |    2 +-
 arch/arm/boot/dts/tny_a9260.dts             |    4 ++--
 arch/arm/boot/dts/tny_a9263.dts             |    2 +-
 arch/arm/boot/dts/tny_a9g20.dts             |    4 ++--
 arch/arm/boot/dts/usb_a9260.dts             |    4 ++--
 arch/arm/boot/dts/usb_a9263.dts             |    2 +-
 arch/arm/boot/dts/usb_a9g20.dts             |    4 ++--
 47 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/arch/arm/boot/dts/aks-cdu.dts b/arch/arm/boot/dts/aks-cdu.dts
index 29b9f15..08b82a4 100644
--- a/arch/arm/boot/dts/aks-cdu.dts
+++ b/arch/arm/boot/dts/aks-cdu.dts
@@ -9,7 +9,7 @@
 
 /dts-v1/;
 
-/include/ "ge863-pro3.dtsi"
+#include "ge863-pro3.dtsi"
 
 / {
 	chosen {
diff --git a/arch/arm/boot/dts/animeo_ip.dts b/arch/arm/boot/dts/animeo_ip.dts
index 5160210..b765892 100644
--- a/arch/arm/boot/dts/animeo_ip.dts
+++ b/arch/arm/boot/dts/animeo_ip.dts
@@ -7,7 +7,7 @@
  */
 
 /dts-v1/;
-/include/ "at91sam9260.dtsi"
+#include "at91sam9260.dtsi"
 
 / {
 	model = "Somfy Animeo IP";
diff --git a/arch/arm/boot/dts/at91-ariag25.dts b/arch/arm/boot/dts/at91-ariag25.dts
index c7aebba..09beeb4 100644
--- a/arch/arm/boot/dts/at91-ariag25.dts
+++ b/arch/arm/boot/dts/at91-ariag25.dts
@@ -7,7 +7,7 @@
  * Licensed under GPLv2 or later.
  */
 /dts-v1/;
-/include/ "at91sam9g25.dtsi"
+#include "at91sam9g25.dtsi"
 
 / {
 	model = "Acme Systems Aria G25";
diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 5d3ed5a..6329679 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -10,7 +10,7 @@
  * Licensed under GPLv2 or later.
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	model = "Atmel AT91RM9200 family SoC";
diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91rm9200ek.dts
index e586d85..5dffeb3 100644
--- a/arch/arm/boot/dts/at91rm9200ek.dts
+++ b/arch/arm/boot/dts/at91rm9200ek.dts
@@ -6,7 +6,7 @@
  * Licensed under GPLv2 only
  */
 /dts-v1/;
-/include/ "at91rm9200.dtsi"
+#include "at91rm9200.dtsi"
 
 / {
 	model = "Atmel AT91RM9200 evaluation kit";
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 70b5ccb..b130b3e 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -8,7 +8,7 @@
  * Licensed under GPLv2 or later.
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	model = "Atmel AT91SAM9260 family SoC";
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 94b58ab..89f4e94 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -6,7 +6,7 @@
  * Licensed under GPLv2 only.
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	model = "Atmel AT91SAM9263 family SoC";
diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index 3b82d91..6b646d4 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -6,7 +6,7 @@
  * Licensed under GPLv2 only
  */
 /dts-v1/;
-/include/ "at91sam9263.dtsi"
+#include "at91sam9263.dtsi"
 
 / {
 	model = "Atmel at91sam9263ek";
diff --git a/arch/arm/boot/dts/at91sam9g15.dtsi b/arch/arm/boot/dts/at91sam9g15.dtsi
index 28467fd..cfd7044 100644
--- a/arch/arm/boot/dts/at91sam9g15.dtsi
+++ b/arch/arm/boot/dts/at91sam9g15.dtsi
@@ -6,7 +6,7 @@
  * Licensed under GPLv2.
  */
 
-/include/ "at91sam9x5.dtsi"
+#include "at91sam9x5.dtsi"
 
 / {
 	model = "Atmel AT91SAM9G15 SoC";
diff --git a/arch/arm/boot/dts/at91sam9g15ek.dts b/arch/arm/boot/dts/at91sam9g15ek.dts
index 5427b2d..26b0444 100644
--- a/arch/arm/boot/dts/at91sam9g15ek.dts
+++ b/arch/arm/boot/dts/at91sam9g15ek.dts
@@ -7,8 +7,8 @@
  * Licensed under GPLv2 or later.
  */
 /dts-v1/;
-/include/ "at91sam9g15.dtsi"
-/include/ "at91sam9x5ek.dtsi"
+#include "at91sam9g15.dtsi"
+#include "at91sam9x5ek.dtsi"
 
 / {
 	model = "Atmel AT91SAM9G15-EK";
diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index 75ce6e7..b8e7946 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -6,7 +6,7 @@
  * Licensed under GPLv2.
  */
 
-/include/ "at91sam9260.dtsi"
+#include "at91sam9260.dtsi"
 
 / {
 	model = "Atmel AT91SAM9G20 family SoC";
diff --git a/arch/arm/boot/dts/at91sam9g20ek.dts b/arch/arm/boot/dts/at91sam9g20ek.dts
index e5324bf..3f15a3f 100644
--- a/arch/arm/boot/dts/at91sam9g20ek.dts
+++ b/arch/arm/boot/dts/at91sam9g20ek.dts
@@ -6,7 +6,7 @@
  * Licensed under GPLv2.
  */
 /dts-v1/;
-/include/ "at91sam9g20ek_common.dtsi"
+#include "at91sam9g20ek_common.dtsi"
 
 / {
 	model = "Atmel at91sam9g20ek";
diff --git a/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts b/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts
index 66467b1..942aa10 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts
+++ b/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts
@@ -6,7 +6,7 @@
  * Licensed under GPLv2.
  */
 /dts-v1/;
-/include/ "at91sam9g20ek_common.dtsi"
+#include "at91sam9g20ek_common.dtsi"
 
 / {
 	model = "Atmel at91sam9g20ek 2 mmc";
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index 6a92c5b..253960f 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -5,7 +5,7 @@
  *
  * Licensed under GPLv2.
  */
-/include/ "at91sam9g20.dtsi"
+#include "at91sam9g20.dtsi"
 
 / {
 
diff --git a/arch/arm/boot/dts/at91sam9g25.dtsi b/arch/arm/boot/dts/at91sam9g25.dtsi
index 5fd32df..b4ec6fe 100644
--- a/arch/arm/boot/dts/at91sam9g25.dtsi
+++ b/arch/arm/boot/dts/at91sam9g25.dtsi
@@ -6,7 +6,7 @@
  * Licensed under GPLv2.
  */
 
-/include/ "at91sam9x5.dtsi"
+#include "at91sam9x5.dtsi"
 
 / {
 	model = "Atmel AT91SAM9G25 SoC";
diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
index a1c511f..1e4c49c 100644
--- a/arch/arm/boot/dts/at91sam9g25ek.dts
+++ b/arch/arm/boot/dts/at91sam9g25ek.dts
@@ -7,8 +7,8 @@
  * Licensed under GPLv2 or later.
  */
 /dts-v1/;
-/include/ "at91sam9g25.dtsi"
-/include/ "at91sam9x5ek.dtsi"
+#include "at91sam9g25.dtsi"
+#include "at91sam9x5ek.dtsi"
 
 / {
 	model = "Atmel AT91SAM9G25-EK";
diff --git a/arch/arm/boot/dts/at91sam9g35.dtsi b/arch/arm/boot/dts/at91sam9g35.dtsi
index d6fa8af..bebf9f5 100644
--- a/arch/arm/boot/dts/at91sam9g35.dtsi
+++ b/arch/arm/boot/dts/at91sam9g35.dtsi
@@ -6,7 +6,7 @@
  * Licensed under GPLv2.
  */
 
-/include/ "at91sam9x5.dtsi"
+#include "at91sam9x5.dtsi"
 
 / {
 	model = "Atmel AT91SAM9G35 SoC";
diff --git a/arch/arm/boot/dts/at91sam9g35ek.dts b/arch/arm/boot/dts/at91sam9g35ek.dts
index 6f58ab8..641a9bf 100644
--- a/arch/arm/boot/dts/at91sam9g35ek.dts
+++ b/arch/arm/boot/dts/at91sam9g35ek.dts
@@ -7,8 +7,8 @@
  * Licensed under GPLv2 or later.
  */
 /dts-v1/;
-/include/ "at91sam9g35.dtsi"
-/include/ "at91sam9x5ek.dtsi"
+#include "at91sam9g35.dtsi"
+#include "at91sam9x5ek.dtsi"
 
 / {
 	model = "Atmel AT91SAM9G35-EK";
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index bf18a73..18ea761 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -9,7 +9,7 @@
  * Licensed under GPLv2 or later.
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	model = "Atmel AT91SAM9G45 family SoC";
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 51d9251b5..ba1205d 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -7,7 +7,7 @@
  * Licensed under GPLv2 or later.
  */
 /dts-v1/;
-/include/ "at91sam9g45.dtsi"
+#include "at91sam9g45.dtsi"
 
 / {
 	model = "Atmel AT91SAM9M10G45-EK";
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 3de8e6d..e848870 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -7,7 +7,7 @@
  * Licensed under GPLv2 or later.
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	model = "Atmel AT91SAM9N12 SoC";
diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index d30e48b..b9e300e 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -7,7 +7,7 @@
  * Licensed under GPLv2 or later.
  */
 /dts-v1/;
-/include/ "at91sam9n12.dtsi"
+#include "at91sam9n12.dtsi"
 
 / {
 	model = "Atmel AT91SAM9N12-EK";
diff --git a/arch/arm/boot/dts/at91sam9x25.dtsi b/arch/arm/boot/dts/at91sam9x25.dtsi
index 9ac2bc2..3f78d9b 100644
--- a/arch/arm/boot/dts/at91sam9x25.dtsi
+++ b/arch/arm/boot/dts/at91sam9x25.dtsi
@@ -6,7 +6,7 @@
  * Licensed under GPLv2.
  */
 
-/include/ "at91sam9x5.dtsi"
+#include "at91sam9x5.dtsi"
 
 / {
 	model = "Atmel AT91SAM9X25 SoC";
diff --git a/arch/arm/boot/dts/at91sam9x25ek.dts b/arch/arm/boot/dts/at91sam9x25ek.dts
index 3b40d11..8ddbce0 100644
--- a/arch/arm/boot/dts/at91sam9x25ek.dts
+++ b/arch/arm/boot/dts/at91sam9x25ek.dts
@@ -7,8 +7,8 @@
  * Licensed under GPLv2 or later.
  */
 /dts-v1/;
-/include/ "at91sam9x25.dtsi"
-/include/ "at91sam9x5ek.dtsi"
+#include "at91sam9x25.dtsi"
+#include "at91sam9x5ek.dtsi"
 
 / {
 	model = "Atmel AT91SAM9G25-EK";
diff --git a/arch/arm/boot/dts/at91sam9x35.dtsi b/arch/arm/boot/dts/at91sam9x35.dtsi
index ba67d83..1a3d525 100644
--- a/arch/arm/boot/dts/at91sam9x35.dtsi
+++ b/arch/arm/boot/dts/at91sam9x35.dtsi
@@ -6,7 +6,7 @@
  * Licensed under GPLv2.
  */
 
-/include/ "at91sam9x5.dtsi"
+#include "at91sam9x5.dtsi"
 
 / {
 	model = "Atmel AT91SAM9X35 SoC";
diff --git a/arch/arm/boot/dts/at91sam9x35ek.dts b/arch/arm/boot/dts/at91sam9x35ek.dts
index 6ad19a0..343d328 100644
--- a/arch/arm/boot/dts/at91sam9x35ek.dts
+++ b/arch/arm/boot/dts/at91sam9x35ek.dts
@@ -7,8 +7,8 @@
  * Licensed under GPLv2 or later.
  */
 /dts-v1/;
-/include/ "at91sam9x35.dtsi"
-/include/ "at91sam9x5ek.dtsi"
+#include "at91sam9x35.dtsi"
+#include "at91sam9x5ek.dtsi"
 
 / {
 	model = "Atmel AT91SAM9X35-EK";
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 1145ac3..69b386f 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -9,7 +9,7 @@
  * Licensed under GPLv2 or later.
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	model = "Atmel AT91SAM9x5 family SoC";
diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index 1fa48d2..24781f2 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -6,7 +6,7 @@
  *
  * Licensed under GPLv2 or later.
  */
-/include/ "at91sam9x5cm.dtsi"
+#include "at91sam9x5cm.dtsi"
 
 / {
 	model = "Atmel AT91SAM9X5-EK";
diff --git a/arch/arm/boot/dts/ethernut5.dts b/arch/arm/boot/dts/ethernut5.dts
index 1ea9d34..2067c66 100644
--- a/arch/arm/boot/dts/ethernut5.dts
+++ b/arch/arm/boot/dts/ethernut5.dts
@@ -6,7 +6,7 @@
  * Licensed under GPLv2.
  */
 /dts-v1/;
-/include/ "at91sam9260.dtsi"
+#include "at91sam9260.dtsi"
 
 / {
 	model = "Ethernut 5";
diff --git a/arch/arm/boot/dts/evk-pro3.dts b/arch/arm/boot/dts/evk-pro3.dts
index 96e50f5..eae2cd7 100644
--- a/arch/arm/boot/dts/evk-pro3.dts
+++ b/arch/arm/boot/dts/evk-pro3.dts
@@ -9,7 +9,7 @@
 
 /dts-v1/;
 
-/include/ "ge863-pro3.dtsi"
+#include "ge863-pro3.dtsi"
 
 / {
 	model = "Telit EVK-PRO3 for Telit GE863-PRO3";
@@ -50,4 +50,4 @@
 		status = "okay";
 	};
 
-};
\ No newline at end of file
+};
diff --git a/arch/arm/boot/dts/ge863-pro3.dtsi b/arch/arm/boot/dts/ge863-pro3.dtsi
index 17136fc..230099b 100644
--- a/arch/arm/boot/dts/ge863-pro3.dtsi
+++ b/arch/arm/boot/dts/ge863-pro3.dtsi
@@ -7,7 +7,7 @@
  * Licensed under GPLv2 or later.
  */
 
-/include/ "at91sam9260.dtsi"
+#include "at91sam9260.dtsi"
 
 / {
 	clocks {
diff --git a/arch/arm/boot/dts/kizbox.dts b/arch/arm/boot/dts/kizbox.dts
index b4dc3ed..8328fed 100644
--- a/arch/arm/boot/dts/kizbox.dts
+++ b/arch/arm/boot/dts/kizbox.dts
@@ -6,7 +6,7 @@
  * Licensed under GPLv2.
  */
 /dts-v1/;
-/include/ "at91sam9g20.dtsi"
+#include "at91sam9g20.dtsi"
 
 / {
 
@@ -137,4 +137,4 @@
 			gpio-key,wakeup;
 		};
 	};
-};
\ No newline at end of file
+};
diff --git a/arch/arm/boot/dts/mpa1600.dts b/arch/arm/boot/dts/mpa1600.dts
index 3173008..f1b54a2 100644
--- a/arch/arm/boot/dts/mpa1600.dts
+++ b/arch/arm/boot/dts/mpa1600.dts
@@ -6,7 +6,7 @@
  * Licensed under GPLv2 only
  */
 /dts-v1/;
-/include/ "at91rm9200.dtsi"
+#include "at91rm9200.dtsi"
 
 / {
 	model = "Phontech MPA 1600";
diff --git a/arch/arm/boot/dts/pm9g45.dts b/arch/arm/boot/dts/pm9g45.dts
index 387fedb..639410b 100644
--- a/arch/arm/boot/dts/pm9g45.dts
+++ b/arch/arm/boot/dts/pm9g45.dts
@@ -6,7 +6,7 @@
  * Licensed under GPLv2.
  */
 /dts-v1/;
-/include/ "at91sam9g45.dtsi"
+#include "at91sam9g45.dtsi"
 
 / {
 	model = "Ronetix pm9g45";
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 2e643ea..2293fa1 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -8,7 +8,7 @@
  * Licensed under GPLv2 or later.
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	model = "Atmel SAMA5D3 family SoC";
diff --git a/arch/arm/boot/dts/sama5d31ek.dts b/arch/arm/boot/dts/sama5d31ek.dts
index fa5d216..5bffd66 100644
--- a/arch/arm/boot/dts/sama5d31ek.dts
+++ b/arch/arm/boot/dts/sama5d31ek.dts
@@ -7,8 +7,8 @@
  * Licensed under GPLv2 or later.
  */
 /dts-v1/;
-/include/ "sama5d3xmb.dtsi"
-/include/ "sama5d3xdm.dtsi"
+#include "sama5d3xmb.dtsi"
+#include "sama5d3xdm.dtsi"
 
 / {
 	model = "Atmel SAMA5D31-EK";
diff --git a/arch/arm/boot/dts/sama5d33ek.dts b/arch/arm/boot/dts/sama5d33ek.dts
index c38c943..99bd0c8 100644
--- a/arch/arm/boot/dts/sama5d33ek.dts
+++ b/arch/arm/boot/dts/sama5d33ek.dts
@@ -7,8 +7,8 @@
  * Licensed under GPLv2 or later.
  */
 /dts-v1/;
-/include/ "sama5d3xmb.dtsi"
-/include/ "sama5d3xdm.dtsi"
+#include "sama5d3xmb.dtsi"
+#include "sama5d3xdm.dtsi"
 
 / {
 	model = "Atmel SAMA5D33-EK";
diff --git a/arch/arm/boot/dts/sama5d34ek.dts b/arch/arm/boot/dts/sama5d34ek.dts
index 6bebfcd..d88ff72 100644
--- a/arch/arm/boot/dts/sama5d34ek.dts
+++ b/arch/arm/boot/dts/sama5d34ek.dts
@@ -7,8 +7,8 @@
  * Licensed under GPLv2 or later.
  */
 /dts-v1/;
-/include/ "sama5d3xmb.dtsi"
-/include/ "sama5d3xdm.dtsi"
+#include "sama5d3xmb.dtsi"
+#include "sama5d3xdm.dtsi"
 
 / {
 	model = "Atmel SAMA5D34-EK";
diff --git a/arch/arm/boot/dts/sama5d35ek.dts b/arch/arm/boot/dts/sama5d35ek.dts
index a488fc4..3c364d2 100644
--- a/arch/arm/boot/dts/sama5d35ek.dts
+++ b/arch/arm/boot/dts/sama5d35ek.dts
@@ -7,7 +7,7 @@
  * Licensed under GPLv2 or later.
  */
 /dts-v1/;
-/include/ "sama5d3xmb.dtsi"
+#include "sama5d3xmb.dtsi"
 
 / {
 	model = "Atmel SAMA5D35-EK";
diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi b/arch/arm/boot/dts/sama5d3xcm.dtsi
index 1f8ed40..b552917 100644
--- a/arch/arm/boot/dts/sama5d3xcm.dtsi
+++ b/arch/arm/boot/dts/sama5d3xcm.dtsi
@@ -6,7 +6,7 @@
  *
  * Licensed under GPLv2 or later.
  */
-/include/ "sama5d3.dtsi"
+#include "sama5d3.dtsi"
 
 / {
 	compatible = "atmel,samad3xcm", "atmel,sama5d3", "atmel,sama5";
diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
index 661d7ca..a5e7131 100644
--- a/arch/arm/boot/dts/sama5d3xmb.dtsi
+++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
@@ -6,7 +6,7 @@
  *
  * Licensed under GPLv2 or later.
  */
-/include/ "sama5d3xcm.dtsi"
+#include "sama5d3xcm.dtsi"
 
 / {
 	compatible = "atmel,sama5d3xmb", "atmel,sama5d3xcm", "atmel,sama5d3", "atmel,sama5";
diff --git a/arch/arm/boot/dts/tny_a9260.dts b/arch/arm/boot/dts/tny_a9260.dts
index 367a16d..dabe232 100644
--- a/arch/arm/boot/dts/tny_a9260.dts
+++ b/arch/arm/boot/dts/tny_a9260.dts
@@ -6,8 +6,8 @@
  * Licensed under GPLv2.
  */
 /dts-v1/;
-/include/ "at91sam9260.dtsi"
-/include/ "tny_a9260_common.dtsi"
+#include "at91sam9260.dtsi"
+#include "tny_a9260_common.dtsi"
 
 / {
 	model = "Calao TNY A9260";
diff --git a/arch/arm/boot/dts/tny_a9263.dts b/arch/arm/boot/dts/tny_a9263.dts
index dee9c57..45f059b 100644
--- a/arch/arm/boot/dts/tny_a9263.dts
+++ b/arch/arm/boot/dts/tny_a9263.dts
@@ -6,7 +6,7 @@
  * Licensed under GPLv2 only
  */
 /dts-v1/;
-/include/ "at91sam9263.dtsi"
+#include "at91sam9263.dtsi"
 
 / {
 	model = "Calao TNY A9263";
diff --git a/arch/arm/boot/dts/tny_a9g20.dts b/arch/arm/boot/dts/tny_a9g20.dts
index e1ab64c..8456d70 100644
--- a/arch/arm/boot/dts/tny_a9g20.dts
+++ b/arch/arm/boot/dts/tny_a9g20.dts
@@ -6,8 +6,8 @@
  * Licensed under GPLv2.
  */
 /dts-v1/;
-/include/ "at91sam9g20.dtsi"
-/include/ "tny_a9260_common.dtsi"
+#include "at91sam9g20.dtsi"
+#include "tny_a9260_common.dtsi"
 
 / {
 	model = "Calao TNY A9G20";
diff --git a/arch/arm/boot/dts/usb_a9260.dts b/arch/arm/boot/dts/usb_a9260.dts
index 2962160..a604107 100644
--- a/arch/arm/boot/dts/usb_a9260.dts
+++ b/arch/arm/boot/dts/usb_a9260.dts
@@ -6,8 +6,8 @@
  * Licensed under GPLv2 or later.
  */
 /dts-v1/;
-/include/ "at91sam9260.dtsi"
-/include/ "usb_a9260_common.dtsi"
+#include "at91sam9260.dtsi"
+#include "usb_a9260_common.dtsi"
 
 / {
 	model = "Calao USB A9260";
diff --git a/arch/arm/boot/dts/usb_a9263.dts b/arch/arm/boot/dts/usb_a9263.dts
index 6fe05cc..82e204a 100644
--- a/arch/arm/boot/dts/usb_a9263.dts
+++ b/arch/arm/boot/dts/usb_a9263.dts
@@ -6,7 +6,7 @@
  * Licensed under GPLv2 only
  */
 /dts-v1/;
-/include/ "at91sam9263.dtsi"
+#include "at91sam9263.dtsi"
 
 / {
 	model = "Calao USB A9263";
diff --git a/arch/arm/boot/dts/usb_a9g20.dts b/arch/arm/boot/dts/usb_a9g20.dts
index 2dacb16c..c979c06 100644
--- a/arch/arm/boot/dts/usb_a9g20.dts
+++ b/arch/arm/boot/dts/usb_a9g20.dts
@@ -6,8 +6,8 @@
  * Licensed under GPLv2 or later.
  */
 /dts-v1/;
-/include/ "at91sam9g20.dtsi"
-/include/ "usb_a9260_common.dtsi"
+#include "at91sam9g20.dtsi"
+#include "usb_a9260_common.dtsi"
 
 / {
 	model = "Calao USB A9G20";
-- 
1.7.10.4
