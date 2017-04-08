From: dev@lynxeye.de (Lucas Stach)
Date: Sat,  8 Apr 2017 16:36:05 +0200
Subject: [RFC PATCH 5/7] ARM: dts: imx6*-hummingboard2: remove non-mainline
 property from RTC
In-Reply-To: <20170408143607.15928-1-dev@lynxeye.de>
References: <20170408143607.15928-1-dev@lynxeye.de>
Message-ID: <20170408143607.15928-6-dev@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index 9c4a7d1..31a029c 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -171,7 +171,6 @@
 	pcf8523: rtc at 68 {
 		compatible = "nxp,pcf8523";
 		reg = <0x68>;
-		nxp,12p5_pf;
 	};
 
 	sgtl5000: codec at 0a {
-- 
2.9.3
