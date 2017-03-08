From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  8 Mar 2017 11:28:21 +0800
Subject: [PATCH 2/2] ARM: dts: sunxi: Remove no longer used
 pinctrl/sun4i-a10.h header
In-Reply-To: <20170308032821.26854-1-wens@csie.org>
References: <20170308032821.26854-1-wens@csie.org>
Message-ID: <20170308032821.26854-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All dts files for the sunxi platform have been switched to the generic
pinconf bindings. As a result, the sunxi specific pinctrl macros are
no longer used.

Remove the #include entry with the following command:

    sed --follow-symlinks -i -e '/pinctrl\/sun4i-a10.h/D' \
	arch/arm/boot/dts/sun?i*.*

arch/arm/boot/dts/sun9i-a80.dtsi was then edited to remove the extra
empty line.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun4i-a10-a1000.dts                    | 1 -
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts               | 1 -
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts         | 1 -
 arch/arm/boot/dts/sun4i-a10-hackberry.dts                | 1 -
 arch/arm/boot/dts/sun4i-a10-inet1.dts                    | 1 -
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts             | 1 -
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts               | 1 -
 arch/arm/boot/dts/sun4i-a10-marsboard.dts                | 1 -
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts               | 1 -
 arch/arm/boot/dts/sun4i-a10-mk802.dts                    | 1 -
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts           | 1 -
 arch/arm/boot/dts/sun4i-a10-pcduino.dts                  | 1 -
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts         | 1 -
 arch/arm/boot/dts/sun4i-a10.dtsi                         | 1 -
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts             | 1 -
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts             | 1 -
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts         | 1 -
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts            | 1 -
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts                 | 1 -
 arch/arm/boot/dts/sun5i-a10s.dtsi                        | 1 -
 arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts   | 1 -
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts                 | 1 -
 arch/arm/boot/dts/sun5i-a13-licheepi-one.dts             | 1 -
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts          | 1 -
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts                | 1 -
 arch/arm/boot/dts/sun5i-a13.dtsi                         | 1 -
 arch/arm/boot/dts/sun5i-gr8.dtsi                         | 1 -
 arch/arm/boot/dts/sun5i.dtsi                             | 1 -
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts                | 1 -
 arch/arm/boot/dts/sun6i-a31-colombus.dts                 | 1 -
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts              | 1 -
 arch/arm/boot/dts/sun6i-a31-i7.dts                       | 1 -
 arch/arm/boot/dts/sun6i-a31-m9.dts                       | 1 -
 arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts         | 1 -
 arch/arm/boot/dts/sun6i-a31.dtsi                         | 1 -
 arch/arm/boot/dts/sun6i-a31s-cs908.dts                   | 2 --
 arch/arm/boot/dts/sun6i-a31s-primo81.dts                 | 1 -
 arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi           | 1 -
 arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts | 1 -
 arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi     | 1 -
 arch/arm/boot/dts/sun7i-a20-bananapi.dts                 | 1 -
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts              | 1 -
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts               | 1 -
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts              | 1 -
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts                | 1 -
 arch/arm/boot/dts/sun7i-a20-icnova-swac.dts              | 1 -
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts                | 1 -
 arch/arm/boot/dts/sun7i-a20-m3.dts                       | 1 -
 arch/arm/boot/dts/sun7i-a20-mk808c.dts                   | 1 -
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts           | 1 -
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts           | 1 -
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts          | 1 -
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts          | 1 -
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts            | 1 -
 arch/arm/boot/dts/sun7i-a20-orangepi.dts                 | 1 -
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts                 | 1 -
 arch/arm/boot/dts/sun7i-a20.dtsi                         | 1 -
 arch/arm/boot/dts/sun8i-a23-a33.dtsi                     | 1 -
 arch/arm/boot/dts/sun8i-a23-evb.dts                      | 1 -
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts           | 1 -
 arch/arm/boot/dts/sun8i-a83t.dtsi                        | 2 --
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts        | 1 -
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts          | 1 -
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts                | 1 -
 arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts            | 1 -
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi                   | 1 -
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts                | 1 -
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts             | 1 -
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts              | 1 -
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts               | 1 -
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts              | 1 -
 arch/arm/boot/dts/sun9i-a80-optimus.dts                  | 1 -
 arch/arm/boot/dts/sun9i-a80.dtsi                         | 2 --
 arch/arm/boot/dts/sunxi-common-regulators.dtsi           | 1 -
 arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi     | 1 -
 75 files changed, 78 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index f3fc27412a67..f2a01fe2bebc 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -47,7 +47,6 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Mele A1000";
diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index 04e040e6233d..d844938e2aa7 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -46,7 +46,6 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Cubietech Cubieboard";
diff --git a/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts b/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
index 8317fbfeec4a..aad3bec1cb39 100644
--- a/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
+++ b/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
@@ -46,7 +46,6 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 #include <dt-bindings/pwm/pwm.h>
 
 / {
diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index a48b46474417..a1a7282199d5 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -47,7 +47,6 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Miniand Hackberry";
diff --git a/arch/arm/boot/dts/sun4i-a10-inet1.dts b/arch/arm/boot/dts/sun4i-a10-inet1.dts
index f3092703a1a6..b8923b92cb36 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet1.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet1.dts
@@ -46,7 +46,6 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 #include <dt-bindings/pwm/pwm.h>
 
 / {
diff --git a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
index 4ef2a60a8cd4..4a27eb9102cd 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
@@ -46,7 +46,6 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "iNet-9F Rev 03";
diff --git a/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts b/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
index fc4d4d49e2e2..308dc1513041 100644
--- a/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
+++ b/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
@@ -47,7 +47,6 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Jesurun Q5";
diff --git a/arch/arm/boot/dts/sun4i-a10-marsboard.dts b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
index a2885039d5f1..98a5f7258dca 100644
--- a/arch/arm/boot/dts/sun4i-a10-marsboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
@@ -46,7 +46,6 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "HAOYU Electronics Marsboard A10";
diff --git a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
index af42ebb3a97b..484c57493bd2 100644
--- a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
@@ -47,7 +47,6 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "PineRiver Mini X-Plus";
diff --git a/arch/arm/boot/dts/sun4i-a10-mk802.dts b/arch/arm/boot/dts/sun4i-a10-mk802.dts
index 9c1afd4277d7..2b75745cd246 100644
--- a/arch/arm/boot/dts/sun4i-a10-mk802.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mk802.dts
@@ -44,7 +44,6 @@
 #include "sun4i-a10.dtsi"
 #include "sunxi-common-regulators.dtsi"
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "MK802";
diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
index 214a5accfe93..3a2522a9419d 100644
--- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
@@ -45,7 +45,6 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Olimex A10-OLinuXino-LIME";
diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
index b0365d63ba70..83596fd2ccfc 100644
--- a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
@@ -47,7 +47,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "LinkSprite pcDuino";
diff --git a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
index bfa6bbdaab27..a68c7cc53b94 100644
--- a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
@@ -46,7 +46,6 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 #include <dt-bindings/pwm/pwm.h>
 
 / {
diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index ba20b48c0702..7dc4230da0c0 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -47,7 +47,6 @@
 
 #include <dt-bindings/clock/sun4i-a10-pll2.h>
 #include <dt-bindings/dma/sun4i-a10.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	interrupt-parent = <&intc>;
diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts b/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
index a539b72ce093..c6f742a7e69f 100644
--- a/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
@@ -44,7 +44,6 @@
 #include "sun5i-a10s.dtsi"
 #include "sunxi-common-regulators.dtsi"
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Auxtek t003 A10s hdmi tv-stick";
diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
index e1b5e8a446fe..a27c3fa58736 100644
--- a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
@@ -44,7 +44,6 @@
 #include "sun5i-a10s.dtsi"
 #include "sunxi-common-regulators.dtsi"
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Auxtek t004 A10s hdmi tv-stick";
diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index baee64d61f6d..894f874a5beb 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -48,7 +48,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Olimex A10s-Olinuxino Micro";
diff --git a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
index 51371f9b1cf0..262b3669f04d 100644
--- a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
@@ -45,7 +45,6 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "R7 A10s hdmi tv-stick";
diff --git a/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts b/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
index 99c84e870d91..ea3e5655a61b 100644
--- a/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
@@ -46,7 +46,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "A10s-Wobo i5";
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 074485782a4a..1e38ff80366c 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -47,7 +47,6 @@
 #include "sun5i.dtsi"
 
 #include <dt-bindings/dma/sun4i-a10.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	interrupt-parent = <&intc>;
diff --git a/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts b/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
index 42435454acef..34411d27aadf 100644
--- a/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
+++ b/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
@@ -46,7 +46,6 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 #include <dt-bindings/pwm/pwm.h>
 
 / {
diff --git a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
index 5879a75cf97a..2489c16f7efa 100644
--- a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
+++ b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
@@ -46,7 +46,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "HSG H702";
diff --git a/arch/arm/boot/dts/sun5i-a13-licheepi-one.dts b/arch/arm/boot/dts/sun5i-a13-licheepi-one.dts
index 566cda91a66b..bc883893f4a4 100644
--- a/arch/arm/boot/dts/sun5i-a13-licheepi-one.dts
+++ b/arch/arm/boot/dts/sun5i-a13-licheepi-one.dts
@@ -50,7 +50,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Lichee Pi One";
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
index 60e393e28783..3a831eaf1dfc 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
@@ -46,7 +46,6 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Olimex A13-Olinuxino Micro";
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 940d47e88056..95f591bb8ced 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -48,7 +48,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Olimex A13-Olinuxino";
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 6f8c508e8e70..6436bad94404 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -46,7 +46,6 @@
 
 #include "sun5i.dtsi"
 
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
diff --git a/arch/arm/boot/dts/sun5i-gr8.dtsi b/arch/arm/boot/dts/sun5i-gr8.dtsi
index 8921af3bf1ef..3eb56cad0cea 100644
--- a/arch/arm/boot/dts/sun5i-gr8.dtsi
+++ b/arch/arm/boot/dts/sun5i-gr8.dtsi
@@ -46,7 +46,6 @@
 
 #include <dt-bindings/clock/sun5i-ccu.h>
 #include <dt-bindings/dma/sun4i-a10.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 #include <dt-bindings/reset/sun5i-ccu.h>
 
 / {
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index f3b6e19244f9..fc338ce7af79 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -46,7 +46,6 @@
 
 #include <dt-bindings/clock/sun5i-ccu.h>
 #include <dt-bindings/dma/sun4i-a10.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 #include <dt-bindings/reset/sun5i-ccu.h>
 
 / {
diff --git a/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
index effbdc766938..7f34323a668c 100644
--- a/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
+++ b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
@@ -47,7 +47,6 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Allwinner A31 APP4 EVB1 Evaluation Board";
diff --git a/arch/arm/boot/dts/sun6i-a31-colombus.dts b/arch/arm/boot/dts/sun6i-a31-colombus.dts
index f5ececd45bc0..85eff0307ca4 100644
--- a/arch/arm/boot/dts/sun6i-a31-colombus.dts
+++ b/arch/arm/boot/dts/sun6i-a31-colombus.dts
@@ -47,7 +47,6 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "WITS A31 Colombus Evaluation Board";
diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index f094eeb6c499..d4f74f476f25 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -47,7 +47,6 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Merrii A31 Hummingbird";
diff --git a/arch/arm/boot/dts/sun6i-a31-i7.dts b/arch/arm/boot/dts/sun6i-a31-i7.dts
index 2bc57d2dcd80..010a84c7c012 100644
--- a/arch/arm/boot/dts/sun6i-a31-i7.dts
+++ b/arch/arm/boot/dts/sun6i-a31-i7.dts
@@ -45,7 +45,6 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Mele I7 Quad top set box";
diff --git a/arch/arm/boot/dts/sun6i-a31-m9.dts b/arch/arm/boot/dts/sun6i-a31-m9.dts
index 8af5b667a46d..50605fd4449e 100644
--- a/arch/arm/boot/dts/sun6i-a31-m9.dts
+++ b/arch/arm/boot/dts/sun6i-a31-m9.dts
@@ -45,7 +45,6 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Mele M9 top set box";
diff --git a/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts b/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
index bf0f5831126f..5219556e9f73 100644
--- a/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
+++ b/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
@@ -45,7 +45,6 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Mele A1000G Quad top set box";
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index a4b96184cac1..9c999d3788f6 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -48,7 +48,6 @@
 #include <dt-bindings/thermal/thermal.h>
 
 #include <dt-bindings/clock/sun6i-a31-ccu.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 #include <dt-bindings/reset/sun6i-a31-ccu.h>
 
 / {
diff --git a/arch/arm/boot/dts/sun6i-a31s-cs908.dts b/arch/arm/boot/dts/sun6i-a31s-cs908.dts
index 5e8f8c4f2b30..75e578159c3a 100644
--- a/arch/arm/boot/dts/sun6i-a31s-cs908.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-cs908.dts
@@ -43,8 +43,6 @@
 /dts-v1/;
 #include "sun6i-a31s.dtsi"
 
-#include <dt-bindings/pinctrl/sun4i-a10.h>
-
 / {
 	model = "CSQ CS908 top set box";
 	compatible = "csq,cs908", "allwinner,sun6i-a31s";
diff --git a/arch/arm/boot/dts/sun6i-a31s-primo81.dts b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
index 2238eda318f6..f3712753fa42 100644
--- a/arch/arm/boot/dts/sun6i-a31s-primo81.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
@@ -48,7 +48,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "MSI Primo81 tablet";
diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi b/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
index 4ec0c8679b2e..d7325bc4eeb4 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
@@ -45,7 +45,6 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Sinlinx SinA31s Core Board";
diff --git a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts b/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
index 154ebf5082ed..f3edf9ca435c 100644
--- a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
@@ -45,7 +45,6 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Yones TopTech BS1078 v2 Tablet";
diff --git a/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
index edaba5f904fd..3cc4046b904a 100644
--- a/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
@@ -44,7 +44,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	aliases {
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index 91f2e5f9efcb..ed2f35adf542 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -48,7 +48,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "LeMaker Banana Pi";
diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 4dc1e10f88c4..a2eab7aa80e0 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -48,7 +48,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Cubietech Cubieboard2";
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index f019aa3fe96d..feb995d29799 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -48,7 +48,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Cubietech Cubietruck";
diff --git a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
index e921ba42f170..99c00b9a1546 100644
--- a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
+++ b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
@@ -48,7 +48,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Merrii A20 Hummingbird";
diff --git a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
index 385fd8232ae0..4da49717da21 100644
--- a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
@@ -46,7 +46,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "I12 / Q5 / QT840A A20 tvbox";
diff --git a/arch/arm/boot/dts/sun7i-a20-icnova-swac.dts b/arch/arm/boot/dts/sun7i-a20-icnova-swac.dts
index f5b5325a70e2..28d3abbdc2d4 100644
--- a/arch/arm/boot/dts/sun7i-a20-icnova-swac.dts
+++ b/arch/arm/boot/dts/sun7i-a20-icnova-swac.dts
@@ -46,7 +46,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "ICnova-A20 SWAC";
diff --git a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
index 72ec0d5ae052..072c4e8610ec 100644
--- a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
+++ b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
@@ -46,7 +46,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Lamobo R1";
diff --git a/arch/arm/boot/dts/sun7i-a20-m3.dts b/arch/arm/boot/dts/sun7i-a20-m3.dts
index 0e074bd0e8c9..86f69813683e 100644
--- a/arch/arm/boot/dts/sun7i-a20-m3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-m3.dts
@@ -48,7 +48,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Mele M3";
diff --git a/arch/arm/boot/dts/sun7i-a20-mk808c.dts b/arch/arm/boot/dts/sun7i-a20-mk808c.dts
index 97d7a8b65a03..c4ee30709f3a 100644
--- a/arch/arm/boot/dts/sun7i-a20-mk808c.dts
+++ b/arch/arm/boot/dts/sun7i-a20-mk808c.dts
@@ -53,7 +53,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "mk808c";
diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
index a1450c10b08e..1af5b46862cb 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
@@ -48,7 +48,6 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Olimex A20-Olimex-SOM-EVB";
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
index 1297432c2802..dcd0f7a0dffa 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
@@ -49,7 +49,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Olimex A20-OLinuXino-LIME";
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index 71cca5360728..e7d45425758c 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -46,7 +46,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Olimex A20-OLinuXino-LIME2";
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 3c1680c340b1..6e868b24b83f 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -49,7 +49,6 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Olimex A20-Olinuxino Micro";
diff --git a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts b/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
index a74265749227..7af4c8fc1865 100644
--- a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
+++ b/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
@@ -48,7 +48,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Orange Pi Mini";
diff --git a/arch/arm/boot/dts/sun7i-a20-orangepi.dts b/arch/arm/boot/dts/sun7i-a20-orangepi.dts
index 3de980c8f8ff..0a8d4a05e8a0 100644
--- a/arch/arm/boot/dts/sun7i-a20-orangepi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-orangepi.dts
@@ -48,7 +48,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Orange Pi";
diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
index 4599f98a3aee..7c96b53b76bf 100644
--- a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
@@ -48,7 +48,6 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "LinkSprite pcDuino3";
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 2db97fc820dd..f767aa56d882 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -49,7 +49,6 @@
 
 #include <dt-bindings/clock/sun4i-a10-pll2.h>
 #include <dt-bindings/dma/sun4i-a10.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	interrupt-parent = <&gic>;
diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 8a3ed21cb7bc..5e8725d770f9 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -47,7 +47,6 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #include <dt-bindings/clock/sun8i-a23-a33-ccu.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 #include <dt-bindings/reset/sun8i-a23-a33-ccu.h>
 
 / {
diff --git a/arch/arm/boot/dts/sun8i-a23-evb.dts b/arch/arm/boot/dts/sun8i-a23-evb.dts
index c21f5b1b255e..87289a60c520 100644
--- a/arch/arm/boot/dts/sun8i-a23-evb.dts
+++ b/arch/arm/boot/dts/sun8i-a23-evb.dts
@@ -48,7 +48,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Allwinner A23 Evaluation Board";
diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index 03b89bdd55ba..cde14b350699 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -48,7 +48,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Sinlinx SinA33";
diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index a789a7caf217..0ec143773ee9 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -47,8 +47,6 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-#include <dt-bindings/pinctrl/sun4i-a10.h>
-
 / {
 	interrupt-parent = <&gic>;
 
diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
index b7ca916d871d..96c32293598a 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -49,7 +49,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Xunlong Orange Pi Zero";
diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index c0c49dd4d3b2..52acbe111cad 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -46,7 +46,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Banana Pi BPI-M2-Plus";
diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index 04b04fb99a51..e7fae65eb5d3 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -46,7 +46,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Beelink X2";
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
index 3ba081c1f555..03ff6f8b93ff 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
@@ -45,7 +45,6 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "FriendlyARM NanoPi NEO Air";
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi b/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
index 2216e68d1838..c6decee41a27 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
@@ -47,7 +47,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	aliases {
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index 047e9e1c6093..5b6d14555b7c 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -46,7 +46,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Xunlong Orange Pi 2";
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
index 22b99b407019..9b47a0def740 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
@@ -46,7 +46,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Xunlong Orange Pi Lite";
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
index 34da853ee037..ea8fd1325356 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
@@ -46,7 +46,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Xunlong Orange Pi One";
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index d43978d3294e..f148111c326d 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -46,7 +46,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Xunlong Orange Pi PC";
diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index 9112a200fd5e..3741ac71c3d6 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -47,7 +47,6 @@
 #include "sun9i-a80.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Cubietech Cubieboard4";
diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 0fc3a87f5576..85f1ad670310 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -46,7 +46,6 @@
 #include "sun9i-a80.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Merrii A80 Optimus Board";
diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 15b6d122f878..759a72317eb8 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -46,8 +46,6 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-#include <dt-bindings/pinctrl/sun4i-a10.h>
-
 #include <dt-bindings/clock/sun9i-a80-ccu.h>
 #include <dt-bindings/clock/sun9i-a80-de.h>
 #include <dt-bindings/clock/sun9i-a80-usb.h>
diff --git a/arch/arm/boot/dts/sunxi-common-regulators.dtsi b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
index 17c09fed9e84..ce5c53e4452f 100644
--- a/arch/arm/boot/dts/sunxi-common-regulators.dtsi
+++ b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
@@ -43,7 +43,6 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 &pio {
 	ahci_pwr_pin_a: ahci_pwr_pin at 0 {
diff --git a/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi b/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi
index b8241462fcea..245d0bcde441 100644
--- a/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi
@@ -42,7 +42,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
 #include "sunxi-common-regulators.dtsi"
 
 &i2c0 {
-- 
2.11.0
