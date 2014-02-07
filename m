From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  7 Feb 2014 22:20:40 +0100
Subject: [PATCH v2 2/2] ARM: sunxi: dt: Convert to the new SID compatibles
In-Reply-To: <1391808040-29814-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391808040-29814-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1391808040-29814-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch the device tree to the new compatibles introduced in the SID drivers
to have a common pattern accross all Allwinner SoCs.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 2 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi | 2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 26cf191..affdd1b 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -437,7 +437,7 @@
 		};
 
 		sid: eeprom at 01c23800 {
-			compatible = "allwinner,sun4i-sid";
+			compatible = "allwinner,sun4i-a10-sid";
 			reg = <0x01c23800 0x10>;
 		};
 
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index b114be7..ea38f0f 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -392,7 +392,7 @@
 		};
 
 		sid: eeprom at 01c23800 {
-			compatible = "allwinner,sun4i-sid";
+			compatible = "allwinner,sun4i-a10-sid";
 			reg = <0x01c23800 0x10>;
 		};
 
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 5c121fc..abe3120 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -356,7 +356,7 @@
 		};
 
 		sid: eeprom at 01c23800 {
-			compatible = "allwinner,sun4i-sid";
+			compatible = "allwinner,sun4i-a10-sid";
 			reg = <0x01c23800 0x10>;
 		};
 
-- 
1.8.4.2
