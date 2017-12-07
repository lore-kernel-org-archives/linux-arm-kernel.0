From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu,  7 Dec 2017 16:09:23 +0100
Subject: [PATCH] ARM: dts: imx6: RDU2: correct RTC compatible
Message-ID: <20171207150923.25024-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RTC is manufactured by Maxim. This is a cosmetic fix, as Linux
doesn't match the vendor string for i2c devices.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index eef737bd52d9..6bef9a98678e 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -581,7 +581,7 @@
 	};
 
 	ds1341: rtc at 68 {
-		compatible = "dallas,ds1341";
+		compatible = "maxim,ds1341";
 		reg = <0x68>;
 	};
 };
-- 
2.11.0
