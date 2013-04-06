From: aletes.xgr@gmail.com (Alexandre Pereira da Silva)
Date: Sat,  6 Apr 2013 10:42:10 -0300
Subject: [PATCH] ARM: dts: imx23-olinuxino: mark sdcard cd as broken
Message-ID: <1365255730-6299-1-git-send-email-aletes.xgr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx23-olinuxino sdcard doesn't have card detect.

Signed-off-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
---
 arch/arm/boot/dts/imx23-olinuxino.dts |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
index a43141a..d4cc9f8 100644
--- a/arch/arm/boot/dts/imx23-olinuxino.dts
+++ b/arch/arm/boot/dts/imx23-olinuxino.dts
@@ -29,6 +29,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&mmc0_4bit_pins_a &mmc0_pins_fixup>;
 				bus-width = <4>;
+				broken-cd;
 				status = "okay";
 			};
 
-- 
1.7.10
