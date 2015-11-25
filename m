From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 25 Nov 2015 09:11:23 -0300
Subject: [PATCH] ARM: dts: Remove unneeded GPIO include in exynos4412-odroidu3
Message-ID: <1448453483-3338-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The <dt-bindings/gpio/gpio.h> header is already included in the
exynos4412-odroid-common DTSI so there's no need to do it again
in the DTS file.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 arch/arm/boot/dts/exynos4412-odroidu3.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index 646ff0bd001a..dd89f7b37c9f 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -13,7 +13,6 @@
 
 /dts-v1/;
 #include "exynos4412-odroid-common.dtsi"
-#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Hardkernel ODROID-U3 board based on Exynos4412";
-- 
2.4.3
