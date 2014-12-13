From: silvio.fricke@gmail.com (Silvio Fricke)
Date: Sat, 13 Dec 2014 02:46:48 +0100
Subject: [PATCH 3/3] ARM: SPEAr: dts: remove unused irq-trigger,
 id and block entries
In-Reply-To: <cover.1418434448.git.silvio.fricke@gmail.com>
References: <cover.1418434448.git.silvio.fricke@gmail.com>
Message-ID: <557b9b23d0313dede22786d9550c7867d9f22837.1418434448.git.silvio.fricke@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Silvio Fricke <silvio.fricke@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Jason Cooper <jason@lakedaemon.net>
CC: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/boot/dts/spear1310-evb.dts | 1 -
 arch/arm/boot/dts/spear1340-evb.dts | 2 --
 arch/arm/boot/dts/spear320-hmi.dts  | 3 ---
 3 files changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/spear1310-evb.dts b/arch/arm/boot/dts/spear1310-evb.dts
index d42c84b..95c2ff1 100644
--- a/arch/arm/boot/dts/spear1310-evb.dts
+++ b/arch/arm/boot/dts/spear1310-evb.dts
@@ -369,7 +369,6 @@
 					pl022,duplex = <0>;
 					interrupts = <6 0x4>;
 					interrupt-parent = <&gpio1>;
-					irq-trigger = <0x2>;
 
 					stmpe_touchscreen {
 						compatible = "st,stmpe-ts";
diff --git a/arch/arm/boot/dts/spear1340-evb.dts b/arch/arm/boot/dts/spear1340-evb.dts
index b23e05e..bba3389 100644
--- a/arch/arm/boot/dts/spear1340-evb.dts
+++ b/arch/arm/boot/dts/spear1340-evb.dts
@@ -325,7 +325,6 @@
 					reg = <0x41>;
 					interrupts = <4 0x4>;
 					interrupt-parent = <&gpio0>;
-					irq-trigger = <0x2>;
 
 					stmpegpio: stmpe_gpio {
 						compatible = "st,stmpe-gpio";
@@ -478,7 +477,6 @@
 					pl022,duplex = <0>;
 					interrupts = <100 0>;
 					interrupt-parent = <&gpiopinctrl>;
-					irq-trigger = <0x2>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 
diff --git a/arch/arm/boot/dts/spear320-hmi.dts b/arch/arm/boot/dts/spear320-hmi.dts
index 0aa6fef..f8ed01e 100644
--- a/arch/arm/boot/dts/spear320-hmi.dts
+++ b/arch/arm/boot/dts/spear320-hmi.dts
@@ -243,9 +243,6 @@
 					reg = <0x41>;
 					irq-over-gpio;
 					irq-gpios = <&gpiopinctrl 29 0x4>;
-					id = <0>;
-					blocks = <0x5>;
-					irq-trigger = <0x1>;
 
 					stmpegpio: stmpe-gpio {
 						compatible = "stmpe,gpio";
-- 
2.1.3
