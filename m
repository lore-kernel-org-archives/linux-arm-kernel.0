From: francescolavra.fl@gmail.com (Francesco Lavra)
Date: Sun, 13 Apr 2014 20:03:03 +0200
Subject: [PATCH] ARM: vexpress: Add CPU clock frequencies to TC1 device tree
Message-ID: <534AD157.2000105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
index 7cbe38c..97e7634 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
@@ -39,12 +39,14 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0>;
+			clock-frequency = <1000000000>;
 		};
 
 		cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <1>;
+			clock-frequency = <1000000000>;
 		};
 	};
 
-- 
1.7.5.4
