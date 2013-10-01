From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:39:21 +0900
Subject: [PATCH 3/3] ARM: shmobile: Add r8a7790 CA7 CPU cores to DTSI
In-Reply-To: <cover.1380530263.git.horms+renesas@verge.net.au>
References: <cover.1380530263.git.horms+renesas@verge.net.au>
Message-ID: <2007e74ca3769fd353fe87a7a105c14102d7980c.1380530263.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add r8a7790 Cortex-A7 CPU information to DTSI.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 388f49f..a0cfb661 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -45,6 +45,34 @@
 			reg = <3>;
 			clock-frequency = <1300000000>;
 		};
+
+		cpu4: cpu at 4 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x100>;
+			clock-frequency = <780000000>;
+		};
+
+		cpu5: cpu at 5 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x101>;
+			clock-frequency = <780000000>;
+		};
+
+		cpu6: cpu at 6 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x102>;
+			clock-frequency = <780000000>;
+		};
+
+		cpu7: cpu at 7 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x103>;
+			clock-frequency = <780000000>;
+		};
 	};
 
 	gic: interrupt-controller at f1001000 {
-- 
1.8.4
