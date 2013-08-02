From: afzal@ti.com (Afzal Mohammed)
Date: Fri, 2 Aug 2013 19:16:13 +0530
Subject: [PATCH 1/2] ARM: dts: AM4372: cpu(s) node per latest binding
Message-ID: <ffa2f76fcac54bfe76c234ffce0394fd2c25fe52.1375450395.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update AM4372 cpu node to the latest cpus/cpu bindings for ARM.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index ddc1df7..4635e7f 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -22,8 +22,12 @@
 	};
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		cpu at 0 {
 			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <0>;
 		};
 	};
 
-- 
1.7.9.5
