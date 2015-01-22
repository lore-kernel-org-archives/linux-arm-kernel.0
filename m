From: marek@goldelico.com (Marek Belisko)
Date: Thu, 22 Jan 2015 21:38:14 +0100
Subject: [PATCH 08/13] ARM: dts: omap3-gta04: add comments about gpios
In-Reply-To: <1421959099-28319-1-git-send-email-marek@goldelico.com>
References: <1421959099-28319-1-git-send-email-marek@goldelico.com>
Message-ID: <1421959099-28319-9-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: NeilBrown <neil@brown.name>

Add comments to state which GPIO is used for some interrupts.

Signed-off-by: NeilBrown <neil@brown.name>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 6f5fcbb..b65b5ed 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -229,7 +229,7 @@
 		compatible = "bosch,bmp085";
 		reg = <0x77>;
 		interrupt-parent = <&gpio4>;
-		interrupts = <17 IRQ_TYPE_EDGE_RISING>;
+		interrupts = <17 IRQ_TYPE_EDGE_RISING>; /* GPIO_113 */
 	};
 
 	/* accelerometer */
@@ -237,7 +237,7 @@
 		compatible = "bosch,bma180";
 		reg = <0x41>;
 		interrupt-parent = <&gpio4>;
-		interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <19 IRQ_TYPE_LEVEL_HIGH>; /* GPIO_115 */
 	};
 
 	/* leds */
@@ -288,7 +288,7 @@
 		compatible = "ti,tsc2007";
 		reg = <0x48>;
 		interrupt-parent = <&gpio6>;
-		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+		interrupts = <0 IRQ_TYPE_EDGE_FALLING>; /* GPIO_160 */
 		gpios = <&gpio6 0 GPIO_ACTIVE_LOW>;
 		ti,x-plate-ohms = <600>;
 	};
-- 
1.9.1
