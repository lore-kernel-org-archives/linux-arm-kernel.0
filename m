From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 16 Dec 2014 22:59:54 +0100
Subject: [PATCH 1/6] ARM: sunxi: DT: Convert to device tree includes
Message-ID: <1418767199-20957-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare the device trees to use the C preprocessor.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10-a1000.dts            | 4 ++--
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts       | 4 ++--
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts       | 4 ++--
 arch/arm/boot/dts/sun4i-a10-hackberry.dts        | 4 ++--
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts        | 4 ++--
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts       | 4 ++--
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts   | 4 ++--
 arch/arm/boot/dts/sun4i-a10-pcduino.dts          | 4 ++--
 arch/arm/boot/dts/sun4i-a10.dtsi                 | 2 +-
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 4 ++--
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts    | 4 ++--
 arch/arm/boot/dts/sun5i-a10s.dtsi                | 2 +-
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts         | 4 ++--
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts  | 4 ++--
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts        | 4 ++--
 arch/arm/boot/dts/sun5i-a13.dtsi                 | 2 +-
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts        | 4 ++--
 arch/arm/boot/dts/sun6i-a31-colombus.dts         | 4 ++--
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts      | 4 ++--
 arch/arm/boot/dts/sun6i-a31-m9.dts               | 4 ++--
 arch/arm/boot/dts/sun6i-a31.dtsi                 | 2 +-
 arch/arm/boot/dts/sun7i-a20-bananapi.dts         | 4 ++--
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts      | 4 ++--
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts       | 4 ++--
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts      | 4 ++--
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts        | 4 ++--
 arch/arm/boot/dts/sun7i-a20-m3.dts               | 4 ++--
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts   | 4 ++--
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts  | 4 ++--
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts  | 4 ++--
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts         | 4 ++--
 arch/arm/boot/dts/sun7i-a20.dtsi                 | 2 +-
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts      | 4 ++--
 arch/arm/boot/dts/sun8i-a23.dtsi                 | 2 +-
 arch/arm/boot/dts/sun9i-a80-optimus.dts          | 2 +-
 arch/arm/boot/dts/sun9i-a80.dtsi                 | 2 +-
 36 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index 3bcfd81837f0..3bb636978582 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -48,8 +48,8 @@
  */
 
 /dts-v1/;
-/include/ "sun4i-a10.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun4i-a10.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Mele A1000";
diff --git a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
index f3f2974658e4..b2b45c4f7915 100644
--- a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
+++ b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
@@ -46,8 +46,8 @@
  */
 
 /dts-v1/;
-/include/ "sun4i-a10.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun4i-a10.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "BA10 tvbox";
diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index 6a310da53f18..c5691a8666c5 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -47,8 +47,8 @@
  */
 
 /dts-v1/;
-/include/ "sun4i-a10.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun4i-a10.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Cubietech Cubieboard";
diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index efc116287e0f..0c6c81a6b61b 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -48,8 +48,8 @@
  */
 
 /dts-v1/;
-/include/ "sun4i-a10.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun4i-a10.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Miniand Hackberry";
diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
index 3e25ee4d3248..5980ad0e69e3 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
@@ -48,8 +48,8 @@
  */
 
 /dts-v1/;
-/include/ "sun4i-a10.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun4i-a10.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "INet-97F Rev 02";
diff --git a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
index 8b3f97470249..e55639988e5d 100644
--- a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
@@ -48,8 +48,8 @@
  */
 
 /dts-v1/;
-/include/ "sun4i-a10.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun4i-a10.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "PineRiver Mini X-Plus";
diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
index 88cf1a531155..3f607946abad 100644
--- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
@@ -46,8 +46,8 @@
  */
 
 /dts-v1/;
-/include/ "sun4i-a10.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun4i-a10.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Olimex A10-OLinuXino-LIME";
diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
index ce5994597407..7367eff79dea 100644
--- a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
@@ -47,8 +47,8 @@
  */
 
 /dts-v1/;
-/include/ "sun4i-a10.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun4i-a10.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "LinkSprite pcDuino";
diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 7b4099fcf817..69d12ed92406 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -10,7 +10,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	interrupt-parent = <&intc>;
diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index fe3c559ca6a8..29a47dd4bad5 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -48,8 +48,8 @@
  */
 
 /dts-v1/;
-/include/ "sun5i-a10s.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun5i-a10s.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Olimex A10s-Olinuxino Micro";
diff --git a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
index 1fa2916eafc2..3a0d9dc39914 100644
--- a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
@@ -46,8 +46,8 @@
  */
 
 /dts-v1/;
-/include/ "sun5i-a10s.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun5i-a10s.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "R7 A10s hdmi tv-stick";
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 1b76667f3182..98dbf4dd2db8 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -11,7 +11,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	interrupt-parent = <&intc>;
diff --git a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
index eeed1f236ee8..ca6b6dd30e47 100644
--- a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
+++ b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
@@ -46,8 +46,8 @@
  */
 
 /dts-v1/;
-/include/ "sun5i-a13.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun5i-a13.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "HSG H702";
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
index 916ee8bb826f..729f02daf605 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
@@ -47,8 +47,8 @@
  */
 
 /dts-v1/;
-/include/ "sun5i-a13.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun5i-a13.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Olimex A13-Olinuxino Micro";
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index e31d291d14cb..0e9e17dcc936 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -48,8 +48,8 @@
  */
 
 /dts-v1/;
-/include/ "sun5i-a13.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun5i-a13.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Olimex A13-Olinuxino";
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index c35217ea1f64..c46549244786 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -11,7 +11,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	interrupt-parent = <&intc>;
diff --git a/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
index c74a63a39531..42a11f4795f7 100644
--- a/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
+++ b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
@@ -48,8 +48,8 @@
  */
 
 /dts-v1/;
-/include/ "sun6i-a31.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun6i-a31.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Allwinner A31 APP4 EVB1 Evaluation Board";
diff --git a/arch/arm/boot/dts/sun6i-a31-colombus.dts b/arch/arm/boot/dts/sun6i-a31-colombus.dts
index c36b4dc89c13..2e5bcaf6e860 100644
--- a/arch/arm/boot/dts/sun6i-a31-colombus.dts
+++ b/arch/arm/boot/dts/sun6i-a31-colombus.dts
@@ -48,8 +48,8 @@
  */
 
 /dts-v1/;
-/include/ "sun6i-a31.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun6i-a31.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "WITS A31 Colombus Evaluation Board";
diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index 55a367ac2a0a..a3bf20930d50 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -48,8 +48,8 @@
  */
 
 /dts-v1/;
-/include/ "sun6i-a31.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun6i-a31.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Merrii A31 Hummingbird";
diff --git a/arch/arm/boot/dts/sun6i-a31-m9.dts b/arch/arm/boot/dts/sun6i-a31-m9.dts
index 3ab544f3af4a..9b47964dcc5a 100644
--- a/arch/arm/boot/dts/sun6i-a31-m9.dts
+++ b/arch/arm/boot/dts/sun6i-a31-m9.dts
@@ -46,8 +46,8 @@
  */
 
 /dts-v1/;
-/include/ "sun6i-a31.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun6i-a31.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Mele M9 / A1000G Quad top set box";
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 0332d1c8b308..9c34e92ade87 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -47,7 +47,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	interrupt-parent = <&gic>;
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index 1cf1214cc068..e9e96584bedd 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -48,8 +48,8 @@
  */
 
 /dts-v1/;
-/include/ "sun7i-a20.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun7i-a20.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "LeMaker Banana Pi";
diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 53680983461a..809d448ecf30 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -12,8 +12,8 @@
  */
 
 /dts-v1/;
-/include/ "sun7i-a20.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun7i-a20.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Cubietech Cubieboard2";
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index a281d259b9b8..9812a3a34831 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -12,8 +12,8 @@
  */
 
 /dts-v1/;
-/include/ "sun7i-a20.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun7i-a20.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Cubietech Cubietruck";
diff --git a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
index 0e4bfa3b2b85..add6d95a0246 100644
--- a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
+++ b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
@@ -12,8 +12,8 @@
  */
 
 /dts-v1/;
-/include/ "sun7i-a20.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun7i-a20.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Merrii A20 Hummingbird";
diff --git a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
index f38bb1a6656c..780f1aa98429 100644
--- a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
@@ -46,8 +46,8 @@
  */
 
 /dts-v1/;
-/include/ "sun7i-a20.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun7i-a20.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "I12 / Q5 / QT840A A20 tvbox";
diff --git a/arch/arm/boot/dts/sun7i-a20-m3.dts b/arch/arm/boot/dts/sun7i-a20-m3.dts
index b8e568c55271..82046234d9e8 100644
--- a/arch/arm/boot/dts/sun7i-a20-m3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-m3.dts
@@ -48,8 +48,8 @@
  */
 
 /dts-v1/;
-/include/ "sun7i-a20.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun7i-a20.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Mele M3";
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
index 3f3ff9693992..996da8be0e44 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
@@ -49,8 +49,8 @@
  */
 
 /dts-v1/;
-/include/ "sun7i-a20.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun7i-a20.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Olimex A20-OLinuXino-LIME";
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index ed364d5e755e..5fda1e02acdb 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -46,8 +46,8 @@
  */
 
 /dts-v1/;
-/include/ "sun7i-a20.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun7i-a20.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Olimex A20-OLinuXino-LIME2";
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 9d669cdf031d..7ed510fe1872 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -12,8 +12,8 @@
  */
 
 /dts-v1/;
-/include/ "sun7i-a20.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun7i-a20.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Olimex A20-Olinuxino Micro";
diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
index 8dca49b2477b..2a9b610931c0 100644
--- a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
@@ -47,8 +47,8 @@
  */
 
 /dts-v1/;
-/include/ "sun7i-a20.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun7i-a20.dtsi"
+#include "sunxi-common-regulators.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index e21ce5992d56..db45d85640ca 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -47,7 +47,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	interrupt-parent = <&gic>;
diff --git a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
index 7f2117ce6985..491cd6ca4e31 100644
--- a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
+++ b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
@@ -48,8 +48,8 @@
  */
 
 /dts-v1/;
-/include/ "sun8i-a23.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun8i-a23.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Ippo Q8H Dual Core Tablet (v5)";
diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 2fcccf0cbcee..30ba73285680 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -47,7 +47,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	interrupt-parent = <&gic>;
diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 506948f582ee..7fe242a8134b 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -48,7 +48,7 @@
  */
 
 /dts-v1/;
-/include/ "sun9i-a80.dtsi"
+#include "sun9i-a80.dtsi"
 
 / {
 	model = "Merrii A80 Optimus Board";
diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 494714f67b57..90d0450850e9 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -47,7 +47,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/include/ "skeleton64.dtsi"
+#include "skeleton64.dtsi"
 
 / {
 	interrupt-parent = <&gic>;
-- 
2.2.0
