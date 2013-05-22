From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 22 May 2013 15:36:42 +0100
Subject: [PATCH] ARM: ux500: Apply other compatible name to the u8540 DTS file
Message-ID: <1369233402-19225-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The common name for the 8540 is the u8540, but the fully qualified
name, or proper name is ccu8540. Ensure both are available to drivers
and platform code that wish to use them.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/ccu8540.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ccu8540.dts b/arch/arm/boot/dts/ccu8540.dts
index 18daa01..af4487f 100644
--- a/arch/arm/boot/dts/ccu8540.dts
+++ b/arch/arm/boot/dts/ccu8540.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "ST-Ericsson U8540 platform with Device Tree";
-	compatible = "st-ericsson,u8540";
+	compatible = "st-ericsson,ccu8540", "st-ericsson,u8540";
 
 	memory {
 		reg = <0x00000000 0x20000000>;
-- 
1.7.10.4
