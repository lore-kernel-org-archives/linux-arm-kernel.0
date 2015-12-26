From: mamlinav@gmail.com (Aleksei Mamlin)
Date: Sat, 26 Dec 2015 12:57:59 +0300
Subject: [PATCH] ARM: dts: sun4i: Use red1 LED for heartbeat indication on
 Marsboard A10
Message-ID: <1451123879-7212-1-git-send-email-mamlinav@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marsboard A10 have four red LEDs, the first one can be used for heartbeat indication.

Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10-marsboard.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-marsboard.dts b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
index 8e50723..ff73ee1 100644
--- a/arch/arm/boot/dts/sun4i-a10-marsboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
@@ -68,6 +68,7 @@
 		red1 {
 			label = "marsboard:red1:usr";
 			gpios = <&pio 1 5 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
 		};
 
 		red2 {
-- 
2.4.10
