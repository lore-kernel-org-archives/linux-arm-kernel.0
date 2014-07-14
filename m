From: stefan@agner.ch (Stefan Agner)
Date: Mon, 14 Jul 2014 09:18:46 +0200
Subject: [PATCH] ARM: dts: vf610: fix length of eshdc1 register property
Message-ID: <1405322326-2183-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf610.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 6cc314e..6a6190c 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -362,7 +362,7 @@
 
 			esdhc1: esdhc at 400b2000 {
 				compatible = "fsl,imx53-esdhc";
-				reg = <0x400b2000 0x4000>;
+				reg = <0x400b2000 0x1000>;
 				interrupts = <0 28 0x04>;
 				clocks = <&clks VF610_CLK_IPG_BUS>,
 					<&clks VF610_CLK_PLATFORM_BUS>,
-- 
2.0.1
