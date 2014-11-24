From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Mon, 24 Nov 2014 17:17:24 +0800
Subject: [PATCH] ARM: ls1021a: dtsi: add 'big-endian' property for scfg node
Message-ID: <1416820644-10968-1-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On LS1021A SoC, the scfg device is in BE mode.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 53c652a..28c37f1 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -142,6 +142,7 @@
 		scfg: scfg at 1570000 {
 			compatible = "fsl,ls1021a-scfg", "syscon";
 			reg = <0x0 0x1570000 0x0 0x10000>;
+			big-endian;
 		};
 
 		clockgen: clocking at 1ee1000 {
-- 
2.1.0.27.g96db324
