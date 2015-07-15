From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 15 Jul 2015 23:21:05 +0200
Subject: [PATCH] ARM: dts: rockchip: add missing device_type = "memory" to
 boards
Message-ID: <1521614.R7mMBQe0OX@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The memory node is supposed to contain a device_type property marking
it as memory. The currently included boards miss this property.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a-bqcurie2.dts  | 1 +
 arch/arm/boot/dts/rk3066a-marsboard.dts | 1 +
 arch/arm/boot/dts/rk3066a-rayeager.dts  | 1 +
 arch/arm/boot/dts/rk3188-radxarock.dts  | 1 +
 arch/arm/boot/dts/rk3288-evb.dtsi       | 1 +
 arch/arm/boot/dts/rk3288-firefly.dtsi   | 1 +
 arch/arm/boot/dts/rk3288-popmetal.dts   | 1 +
 arch/arm/boot/dts/rk3288-r89.dts        | 1 +
 8 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
index b299b26..c027375 100644
--- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
+++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
@@ -49,6 +49,7 @@
 	compatible = "mundoreader,bq-curie2", "rockchip,rk3066a";
 
 	memory {
+		device_type = "memory";
 		reg = <0x60000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/rk3066a-marsboard.dts b/arch/arm/boot/dts/rk3066a-marsboard.dts
index 0a7304b..4355966 100644
--- a/arch/arm/boot/dts/rk3066a-marsboard.dts
+++ b/arch/arm/boot/dts/rk3066a-marsboard.dts
@@ -48,6 +48,7 @@
 	compatible = "haoyu,marsboard-rk3066", "rockchip,rk3066a";
 
 	memory {
+		device_type = "memory";
 		reg = <0x60000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/rk3066a-rayeager.dts b/arch/arm/boot/dts/rk3066a-rayeager.dts
index 3ac1511..7ccd376 100644
--- a/arch/arm/boot/dts/rk3066a-rayeager.dts
+++ b/arch/arm/boot/dts/rk3066a-rayeager.dts
@@ -48,6 +48,7 @@
 	compatible = "chipspark,rayeager-px2", "rockchip,rk3066a";
 
 	memory {
+		device_type = "memory";
 		reg = <0x60000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index 42faa19..4bb014d 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -48,6 +48,7 @@
 	compatible = "radxa,rock", "rockchip,rk3188";
 
 	memory {
+		device_type = "memory";
 		reg = <0x60000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 844a6fb..f6d2e78 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -43,6 +43,7 @@
 
 / {
 	memory {
+		device_type = "memory";
 		reg = <0x0 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 0c66e92..20fa0ef 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -44,6 +44,7 @@
 
 / {
 	memory {
+		device_type = "memory";
 		reg = <0 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/rk3288-popmetal.dts
index d582811..f82b956 100644
--- a/arch/arm/boot/dts/rk3288-popmetal.dts
+++ b/arch/arm/boot/dts/rk3288-popmetal.dts
@@ -49,6 +49,7 @@
 	compatible = "chipspark,popmetal-rk3288", "rockchip,rk3288";
 
 	memory{
+		device_type = "memory";
 		reg = <0 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/rk3288-r89.dts b/arch/arm/boot/dts/rk3288-r89.dts
index b1d9ca6..14b9fc7 100644
--- a/arch/arm/boot/dts/rk3288-r89.dts
+++ b/arch/arm/boot/dts/rk3288-r89.dts
@@ -48,6 +48,7 @@
 	compatible = "netxeon,r89", "rockchip,rk3288";
 
 	memory {
+		device_type = "memory";
 		reg = <0x0 0x80000000>;
 	};
 
-- 
2.1.4
