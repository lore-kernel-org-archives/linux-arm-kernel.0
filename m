From: yinbo.zhu@nxp.com (yinbo.zhu at nxp.com)
Date: Wed, 15 Nov 2017 16:49:55 +0800
Subject: [PATCH v1] arm32: dts: ls1021a: Add a compatible node for ls1021a
 esdhc
Message-ID: <20171115084955.13904-1-yinbo.zhu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "yinbo.zhu" <yinbo.zhu@nxp.com>

The compatible node is to mark the 1021a esdhc HW feature

Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 9319e1f0f1d8..5c0ffd55a3de 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -155,7 +155,7 @@
 		};
 
 		esdhc: esdhc at 1560000 {
-			compatible = "fsl,esdhc";
+			compatible = "fsl,ls1021a-esdhc","fsl,esdhc";
 			reg = <0x0 0x1560000 0x0 0x10000>;
 			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <0>;
-- 
2.14.1
