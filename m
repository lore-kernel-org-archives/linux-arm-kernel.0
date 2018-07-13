From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Fri, 13 Jul 2018 10:30:05 -0700
Subject: [PATCH v2 2/2] ARM: dts: imx51-zii-scu3-esb: Fix RAVE SP watchdog
 compatible string
In-Reply-To: <20180713173005.19552-1-andrew.smirnov@gmail.com>
References: <20180713173005.19552-1-andrew.smirnov@gmail.com>
Message-ID: <20180713173005.19552-3-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It looks like I made a nasty typo in the original patch which resulted
in missing watchdog device. Fix it.

Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: cphealy at gmail.com
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx51-zii-scu3-esb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-zii-scu3-esb.dts b/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
index 0bb42c00d72b..dffb761a1cc8 100644
--- a/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
+++ b/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
@@ -325,7 +325,7 @@
 		#size-cells = <1>;		
 
 		watchdog {
-			compatible = "zii,rave-sp-watchodg-legacy";
+			compatible = "zii,rave-sp-watchdog-legacy";
 		};
 
 		eeprom at a4 {
-- 
2.17.1
