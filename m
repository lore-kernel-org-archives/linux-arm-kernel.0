From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 11 Sep 2018 17:10:42 -0300
Subject: [PATCH 1/6] ARM: dts: imx51: Add label for VPU node
Message-ID: <1536696647-8228-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add label for VPU node so that board dts files can disable VPU
if needed.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx51.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 5c4ba91..268daea 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -608,7 +608,7 @@
 				status = "disabled";
 			};
 
-			vpu at 83ff4000 {
+			vpu: vpu at 83ff4000 {
 				compatible = "fsl,imx51-vpu", "cnm,codahx4";
 				reg = <0x83ff4000 0x1000>;
 				interrupts = <9>;
-- 
2.7.4
