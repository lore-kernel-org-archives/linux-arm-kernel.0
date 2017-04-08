From: dev@lynxeye.de (Lucas Stach)
Date: Sat,  8 Apr 2017 16:36:02 +0200
Subject: [RFC PATCH 2/7] ARM: dts: imx6*-hummingboard2: add SGTL5000 VDDD
 supply
In-Reply-To: <20170408143607.15928-1-dev@lynxeye.de>
References: <20170408143607.15928-1-dev@lynxeye.de>
Message-ID: <20170408143607.15928-3-dev@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VDDD is supplied by VCC_1P8 on HB2.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index 4513e98..8246597 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -182,6 +182,7 @@
 		reg = <0x0a>;
 		VDDA-supply = <&reg_3p3v>;
 		VDDIO-supply = <&reg_3p3v>;
+		VDDD-supply = <&reg_1p8v>;
 	};
 };
 
-- 
2.9.3
