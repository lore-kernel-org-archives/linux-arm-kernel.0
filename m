From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  2 Feb 2014 14:52:40 +0100
Subject: [PATCH] ARM: sunxi: dt: Change the touchscreen compatibles
Message-ID: <1391349160-10951-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch the device tree touchscreen compatibles to have a common pattern accross
all Allwinner SoCs. Since the touchscreen driver has not been merged yet, it
has no side effect.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 2 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi | 2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi  | 2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 040bb0e..e3ff64c 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -426,7 +426,7 @@
 		};
 
 		rtp: rtp at 01c25000 {
-			compatible = "allwinner,sun4i-ts";
+			compatible = "allwinner,sun4i-a10-ts";
 			reg = <0x01c25000 0x100>;
 			interrupts = <29>;
 		};
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index ea16054..8e57a28 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -383,7 +383,7 @@
 		};
 
 		rtp: rtp at 01c25000 {
-			compatible = "allwinner,sun4i-ts";
+			compatible = "allwinner,sun4i-a10-ts";
 			reg = <0x01c25000 0x100>;
 			interrupts = <29>;
 		};
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 320335a..c463fd7 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -346,7 +346,7 @@
 		};
 
 		rtp: rtp at 01c25000 {
-			compatible = "allwinner,sun4i-ts";
+			compatible = "allwinner,sun4i-a10-ts";
 			reg = <0x01c25000 0x100>;
 			interrupts = <29>;
 		};
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 119f066..ccd3790 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -463,7 +463,7 @@
 		};
 
 		rtp: rtp at 01c25000 {
-			compatible = "allwinner,sun4i-ts";
+			compatible = "allwinner,sun4i-a10-ts";
 			reg = <0x01c25000 0x100>;
 			interrupts = <0 29 4>;
 		};
-- 
1.8.4.2
