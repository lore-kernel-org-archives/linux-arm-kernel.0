From: jbe@pengutronix.de (Juergen Borleis)
Date: Thu,  7 Sep 2017 11:05:26 +0200
Subject: [PATCH 5/9] ARM: dts: TQma53: define eMMC's power supply
In-Reply-To: <20170907090530.1241-1-jbe@pengutronix.de>
References: <20170907090530.1241-1-jbe@pengutronix.de>
Message-ID: <20170907090530.1241-6-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eMMC is part of the 'TQma53' CPU card and powered by its on-board power
supply.

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 arch/arm/boot/dts/imx53-tqma53.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx53-tqma53.dtsi b/arch/arm/boot/dts/imx53-tqma53.dtsi
index ceba1004038b1..fa5d712bd47b8 100644
--- a/arch/arm/boot/dts/imx53-tqma53.dtsi
+++ b/arch/arm/boot/dts/imx53-tqma53.dtsi
@@ -57,6 +57,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc3>;
 	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_3p3v>;
 	non-removable;
 	bus-width = <8>;
 	status = "okay";
-- 
2.11.0
