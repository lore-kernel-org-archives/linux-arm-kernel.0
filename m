From: olivier.schonken@gmail.com (Olivier Schonken)
Date: Fri,  1 Jul 2016 16:33:39 +0200
Subject: [PATCH] ARM: dts: at91: sama5d2: add PMU node
Message-ID: <1467383619-6805-1-git-send-email-olivier.schonken@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node to support SAMA5D2 Performance Monitor Unit.

Signed-off-by: Olivier Schonken <olivier.schonken@gmail.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 2827e7a..5d63206 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -72,6 +72,11 @@
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a5-pmu";
+		interrupts = <2 IRQ_TYPE_LEVEL_HIGH 0>;
+	};
+
 	memory {
 		reg = <0x20000000 0x20000000>;
 	};
-- 
1.9.1
