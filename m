From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 4 Feb 2013 23:27:25 +0800
Subject: [PATCH 1/2] ARM: dts: rename imx6q.dtsi to imx6qdl.dtsi
Message-ID: <1359991646-7803-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6 Quad and i.MX6 DualLite is similar enough to share one dtsi
file, so rename imx6q.dtsi to imx6qdl.dtsi preparing for the addition
of imx6dl support.

Another member of i.MX6 series i.MX6 SoloLite is different enough
from the other two, so it will stand as a separate dtsi.  That's why
we rename to imx6qdl.dtsi not imx6.dtsi.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6q-arm2.dts               |    2 +-
 arch/arm/boot/dts/imx6q-sabreauto.dts          |    2 +-
 arch/arm/boot/dts/imx6q-sabrelite.dts          |    2 +-
 arch/arm/boot/dts/imx6q-sabresd.dts            |    2 +-
 arch/arm/boot/dts/{imx6q.dtsi => imx6qdl.dtsi} |    0
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename arch/arm/boot/dts/{imx6q.dtsi => imx6qdl.dtsi} (100%)

diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
index 53eb241..cd5813d 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dts
@@ -11,7 +11,7 @@
  */
 
 /dts-v1/;
-/include/ "imx6q.dtsi"
+/include/ "imx6qdl.dtsi"
 
 / {
 	model = "Freescale i.MX6 Quad Armadillo2 Board";
diff --git a/arch/arm/boot/dts/imx6q-sabreauto.dts b/arch/arm/boot/dts/imx6q-sabreauto.dts
index 656d489..5baa824 100644
--- a/arch/arm/boot/dts/imx6q-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6q-sabreauto.dts
@@ -11,7 +11,7 @@
  */
 
 /dts-v1/;
-/include/ "imx6q.dtsi"
+/include/ "imx6qdl.dtsi"
 
 / {
 	model = "Freescale i.MX6 Quad SABRE Automotive Board";
diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 2ce355c..6aaaf69 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -11,7 +11,7 @@
  */
 
 /dts-v1/;
-/include/ "imx6q.dtsi"
+/include/ "imx6qdl.dtsi"
 
 / {
 	model = "Freescale i.MX6 Quad SABRE Lite Board";
diff --git a/arch/arm/boot/dts/imx6q-sabresd.dts b/arch/arm/boot/dts/imx6q-sabresd.dts
index 2dea304..a48528f 100644
--- a/arch/arm/boot/dts/imx6q-sabresd.dts
+++ b/arch/arm/boot/dts/imx6q-sabresd.dts
@@ -11,7 +11,7 @@
  */
 
 /dts-v1/;
-/include/ "imx6q.dtsi"
+/include/ "imx6qdl.dtsi"
 
 / {
 	model = "Freescale i.MX6Q SABRE Smart Device Board";
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6q.dtsi
rename to arch/arm/boot/dts/imx6qdl.dtsi
-- 
1.7.9.5
