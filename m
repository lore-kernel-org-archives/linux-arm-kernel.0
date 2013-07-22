From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 22 Jul 2013 11:52:20 +0100
Subject: [PATCH 01/22] ARM: ux500: Remove '0x's from HREF v60+ DTS file
Message-ID: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/hrefv60plus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/hrefv60plus.dts b/arch/arm/boot/dts/hrefv60plus.dts
index 3d580d6..46fd8af 100644
--- a/arch/arm/boot/dts/hrefv60plus.dts
+++ b/arch/arm/boot/dts/hrefv60plus.dts
@@ -26,7 +26,7 @@
 
 	soc {
 		i2c at 80110000 {
-			bu21013_tp at 0x5c {
+			bu21013_tp at 5c {
 				reset-gpio = <&gpio4 15 0x4>;
 			};
 		};
-- 
1.8.1.2
