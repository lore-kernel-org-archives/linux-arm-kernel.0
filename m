From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 10 Jun 2013 11:40:40 +0400
Subject: [PATCH] ARM: dts: imx51: Make SDMA firmware name same for DT and
 non-DT
Message-ID: <1370850040-11177-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch will help migrate i.MX51-targets to DT by make SDMA
firmware name same for DT and non-DT cases.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index f23636f..643f005 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -645,7 +645,7 @@
 				interrupts = <6>;
 				clocks = <&clks 56>, <&clks 56>;
 				clock-names = "ipg", "ahb";
-				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx51.bin";
+				fsl,sdma-ram-script-name = "sdma-imx51.bin";
 			};
 
 			cspi: cspi at 83fc0000 {
-- 
1.8.1.5
