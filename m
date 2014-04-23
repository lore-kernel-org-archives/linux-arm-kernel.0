From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 23 Apr 2014 11:58:57 -0300
Subject: [PATCH] ARM: dts: imx27-phytec-phycard-s-rdk: Remove
 'regulator-always-on'
Message-ID: <1398265137-32586-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

There is no point in using 'regulator-always-on' for a fixed regulator that is 
not controlled via GPIO.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
index 3c3964a..3376041 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
@@ -46,7 +46,6 @@
 			regulator-name = "3V3";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
 		};
 	};
 };
-- 
1.8.3.2
