From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 17 May 2013 16:20:50 +0100
Subject: [RFC PATCH v4 07/18] ARM: dts: exynos5440: cpus/cpu nodes dts updates
In-Reply-To: <1368804061-4421-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1368804061-4421-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1368804061-4421-8-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the in-kernel dts files according to the latest cpus
and cpu bindings updates for ARM.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/boot/dts/exynos5440.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index f6b1c89..646677e 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -38,18 +38,22 @@
 		#size-cells = <0>;
 
 		cpu at 0 {
+			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 		};
 		cpu at 1 {
+			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 		};
 		cpu at 2 {
+			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <2>;
 		};
 		cpu at 3 {
+			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <3>;
 		};
-- 
1.8.2.2
