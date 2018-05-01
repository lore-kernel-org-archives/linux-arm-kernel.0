From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 1 May 2018 15:48:33 -0700
Subject: [PATCH] ARM: dts: at91: sama5d4ek: use canonical compatible for
 touchscreen
Message-ID: <20180501224833.GA151132@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The canonical compatible string is "atmel,maxtouch", let's use it. Also,
change the node name to be "touchscreen" rather than driver name.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/boot/dts/at91-sama5d4ek.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d4ek.dts b/arch/arm/boot/dts/at91-sama5d4ek.dts
index 7887a7160a54e..0702a2f2b336c 100644
--- a/arch/arm/boot/dts/at91-sama5d4ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d4ek.dts
@@ -129,8 +129,8 @@
 					wakeup-source;
 				};
 
-				atmel_mxt_ts at 4c {
-					compatible = "atmel,atmel_mxt_ts";
+				touchscreen at 4c {
+					compatible = "atmel,maxtouch";
 					reg = <0x4c>;
 					interrupt-parent = <&pioE>;
 					interrupts = <24 0x0>;
-- 
2.17.0.441.gb46fe60e1d-goog


-- 
Dmitry
