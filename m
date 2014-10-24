From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 24 Oct 2014 17:55:41 +0100
Subject: [PATCH 4/4] ARM: dts: hummingboard: fix configuration of IR input
Message-ID: <E1Xhi9N-0005pT-OA@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the IOMUX setting for the IR input, rather than relying on the
boot loader.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index 1f355804c2cb..62841e85a91e 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -105,7 +105,7 @@
 
 		pinctrl_hummingboard_gpio3_5: hummingboard-gpio3_5 {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_DA5__GPIO3_IO05 0x80000000
+				MX6QDL_PAD_EIM_DA5__GPIO3_IO05 0x1b0b1
 			>;
 		};
 
-- 
1.8.3.1
