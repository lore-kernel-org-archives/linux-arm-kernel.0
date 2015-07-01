From: richardcochran@gmail.com (Richard Cochran)
Date: Wed,  1 Jul 2015 21:34:03 +0200
Subject: [PATCH 2/2] arm: dts: socfpga: Provide the gpio numbers in the
 controller nodes.
In-Reply-To: <cover.1435777856.git.rcochran@linutronix.de>
References: <cover.1435777856.git.rcochran@linutronix.de>
Message-ID: <ae92c1716c6eaa816e07c1551dc1113d6021e93b.1435777856.git.rcochran@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides the base gpio numbers in accordance with the published
data sheet.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
---
 arch/arm/boot/dts/socfpga.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index d9176e6..b3eecc1 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -559,6 +559,7 @@
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
+				snps,base = <0>;
 				snps,nr-gpios = <29>;
 				reg = <0>;
 				interrupt-controller;
@@ -579,6 +580,7 @@
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
+				snps,base = <29>;
 				snps,nr-gpios = <29>;
 				reg = <0>;
 				interrupt-controller;
@@ -599,6 +601,7 @@
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
+				snps,base = <58>;
 				snps,nr-gpios = <27>;
 				reg = <0>;
 				interrupt-controller;
-- 
2.1.4
