From: pali.rohar@gmail.com (=?UTF-8?q?Pali=20Roh=C3=A1r?=)
Date: Wed, 18 Jun 2014 18:57:15 +0200
Subject: [PATCH] omap3-n900.dts: Rename model name to "Nokia RX-51 board"
Message-ID: <1403110635-29696-1-git-send-email-pali.rohar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use same name as in legacy board code. There are lot of userspace applications
which using machine/model name for determinating device type. And changing this
name will break all of them. Due to small features support in DT code only non
DT kernel was used for Nokia N900 until now.

Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
---
 arch/arm/boot/dts/omap3-n900.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 6c6551a..e23ee96 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -13,7 +13,7 @@
 #include <dt-bindings/input/input.h>
 
 / {
-	model = "Nokia N900";
+	model = "Nokia RX-51 board";
 	compatible = "nokia,omap3-n900", "ti,omap3430", "ti,omap3";
 
 	aliases {
-- 
1.7.9.5
