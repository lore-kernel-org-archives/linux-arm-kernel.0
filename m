From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 25 Sep 2015 20:35:30 +0300
Subject: [PATCH 1/5] ARM: dts: i.MX31: fix cpu compatible value
In-Reply-To: <1443202506-13732-1-git-send-email-vz@mleia.com>
References: <1443202506-13732-1-git-send-email-vz@mleia.com>
Message-ID: <1443202534-13816-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change corrects cpu compatible property to a defined one,
see Documentation/devicetree/bindings/arm/cpus.txt

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
---
 arch/arm/boot/dts/imx31.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
index c34f825..5fdb222 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -25,7 +25,7 @@
 		#size-cells = <0>;
 
 		cpu {
-			compatible = "arm,arm1136";
+			compatible = "arm,arm1136jf-s";
 			device_type = "cpu";
 		};
 	};
-- 
2.1.4
