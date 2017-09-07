From: jbe@pengutronix.de (Juergen Borleis)
Date: Thu,  7 Sep 2017 11:05:24 +0200
Subject: [PATCH 3/9] ARM: dts: TQma53: define IRQ's active level by macro
 instead of anonymous number
In-Reply-To: <20170907090530.1241-1-jbe@pengutronix.de>
References: <20170907090530.1241-1-jbe@pengutronix.de>
Message-ID: <20170907090530.1241-4-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 arch/arm/boot/dts/imx53-tqma53.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-tqma53.dtsi b/arch/arm/boot/dts/imx53-tqma53.dtsi
index 4aff91e31f288..eedeced3c8810 100644
--- a/arch/arm/boot/dts/imx53-tqma53.dtsi
+++ b/arch/arm/boot/dts/imx53-tqma53.dtsi
@@ -256,7 +256,7 @@
 		reg = <0x8>;
 		fsl,mc13xxx-uses-rtc;
 		interrupt-parent = <&gpio2>;
-		interrupts = <6 4>; /* PATA_DATA6, active high */
+		interrupts = <6 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	sensor1: lm75 at 48 {
-- 
2.11.0
