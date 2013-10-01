From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:39:20 +0900
Subject: [PATCH 2/3] ARM: shmobile: Add r8a7790 CA15 CPU cores
In-Reply-To: <cover.1380530263.git.horms+renesas@verge.net.au>
References: <cover.1380530263.git.horms+renesas@verge.net.au>
Message-ID: <c1f95979baa9c33c5e6c280d7a8742fad0d20326.1380530263.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add CA15 CPU cores to r8a7790 for a total of 4 x CA15.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 3b879e7..388f49f 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -24,6 +24,27 @@
 			reg = <0>;
 			clock-frequency = <1300000000>;
 		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+			clock-frequency = <1300000000>;
+		};
+
+		cpu2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <2>;
+			clock-frequency = <1300000000>;
+		};
+
+		cpu3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <3>;
+			clock-frequency = <1300000000>;
+		};
 	};
 
 	gic: interrupt-controller at f1001000 {
-- 
1.8.4
