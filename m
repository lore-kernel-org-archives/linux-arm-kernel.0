From: kwizart@gmail.com (Nicolas Chauvet)
Date: Thu,  3 Sep 2015 19:05:35 +0200
Subject: [PATCH] ARM: OMAP2+: Fixup model name for HP t410 dts
Message-ID: <1441299935-22694-1-git-send-email-kwizart@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fix the model name for the device.
Whole string taken from the HP support center web page

Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
---
 arch/arm/boot/dts/dm8148-t410.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dm8148-t410.dts b/arch/arm/boot/dts/dm8148-t410.dts
index 8c4bbc7..19e0b9a 100644
--- a/arch/arm/boot/dts/dm8148-t410.dts
+++ b/arch/arm/boot/dts/dm8148-t410.dts
@@ -8,7 +8,7 @@
 #include "dm814x.dtsi"
 
 / {
-	model = "DM8148 EVM";
+	model = "HP t410 Smart Zero Client";
 	compatible = "hp,t410", "ti,dm8148";
 
 	memory {
-- 
2.4.3
