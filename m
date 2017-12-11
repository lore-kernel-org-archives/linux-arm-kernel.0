From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 11 Dec 2017 16:58:08 +0000
Subject: [PATCH 10/20] ARM: dts: imx6*-hummingboard2: add SGTL5000 VDDD supply
In-Reply-To: <20171211165631.GW10595@n2100.armlinux.org.uk>
References: <20171211165631.GW10595@n2100.armlinux.org.uk>
Message-ID: <E1eORP6-0000Hv-Mk@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lucas Stach <dev@lynxeye.de>

VDDD is supplied by VCC_1P8 on HB2.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index ab809ee0c58c..dfbcdf33b84c 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -178,6 +178,7 @@
 		reg = <0x0a>;
 		VDDA-supply = <&reg_3p3v>;
 		VDDIO-supply = <&reg_3p3v>;
+		VDDD-supply = <&reg_1p8v>;
 	};
 };
 
-- 
2.7.4
