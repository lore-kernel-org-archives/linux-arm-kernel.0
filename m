From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Tue, 26 Sep 2017 08:11:23 +0200
Subject: [PATCH v4 2/2] ARM: socfpga: dtsi: add dw-wdt reset lines
In-Reply-To: <20170926061123.29614-1-o.rempel@pengutronix.de>
References: <20170926061123.29614-1-o.rempel@pengutronix.de>
Message-ID: <20170926061123.29614-2-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/boot/dts/socfpga.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 7e24dc8e82d4..6e49cee084b8 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -924,6 +924,7 @@
 			reg = <0xffd02000 0x1000>;
 			interrupts = <0 171 4>;
 			clocks = <&osc1>;
+			resets = <&rst L4WD0_RESET>;
 			status = "disabled";
 		};
 
@@ -932,6 +933,7 @@
 			reg = <0xffd03000 0x1000>;
 			interrupts = <0 172 4>;
 			clocks = <&osc1>;
+			resets = <&rst L4WD1_RESET>;
 			status = "disabled";
 		};
 	};
-- 
2.11.0
