From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  2 Feb 2014 14:55:25 +0100
Subject: [PATCH 3/3] ARM: sunxi: dt: Update the watchdog compatibles
In-Reply-To: <1391349325-11132-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391349325-11132-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1391349325-11132-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The watchdog compatibles were following a different pattern than the one found
in the other devices. Now that the driver supports the right pattern, switch to
it in the DT.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 2 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi | 2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi  | 2 +-
 arch/arm/boot/dts/sun6i-a31.dtsi  | 2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 040bb0e..f1eb8718 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -410,7 +410,7 @@
 		};
 
 		wdt: watchdog at 01c20c90 {
-			compatible = "allwinner,sun4i-wdt";
+			compatible = "allwinner,sun4i-a10-wdt";
 			reg = <0x01c20c90 0x10>;
 		};
 
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index ea16054..c4a4b23 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -373,7 +373,7 @@
 		};
 
 		wdt: watchdog at 01c20c90 {
-			compatible = "allwinner,sun4i-wdt";
+			compatible = "allwinner,sun4i-a10-wdt";
 			reg = <0x01c20c90 0x10>;
 		};
 
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 320335a..143656b 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -336,7 +336,7 @@
 		};
 
 		wdt: watchdog at 01c20c90 {
-			compatible = "allwinner,sun4i-wdt";
+			compatible = "allwinner,sun4i-a10-wdt";
 			reg = <0x01c20c90 0x10>;
 		};
 
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 5256ad9..cc691d1 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -242,7 +242,7 @@
 		};
 
 		wdt1: watchdog at 01c20ca0 {
-			compatible = "allwinner,sun6i-wdt";
+			compatible = "allwinner,sun6i-a31-wdt";
 			reg = <0x01c20ca0 0x20>;
 		};
 
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 119f066..aaa7b3d 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -447,7 +447,7 @@
 		};
 
 		wdt: watchdog at 01c20c90 {
-			compatible = "allwinner,sun4i-wdt";
+			compatible = "allwinner,sun4i-a10-wdt";
 			reg = <0x01c20c90 0x10>;
 		};
 
-- 
1.8.4.2
