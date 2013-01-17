From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 17 Jan 2013 12:13:25 -0200
Subject: [PATCH] ARM: dts: imx6q: Remove silicon version from SDMA firmware
Message-ID: <1358432005-17990-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove silicon version from SDMA firmware.

This makes it consistent with other i.MX SoCs firmware names.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6q.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index d6265ca..1acf41a 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -797,7 +797,7 @@
 				interrupts = <0 2 0x04>;
 				clocks = <&clks 155>, <&clks 155>;
 				clock-names = "ipg", "ahb";
-				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6q-to1.bin";
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6q.bin";
 			};
 		};
 
-- 
1.7.9.5
