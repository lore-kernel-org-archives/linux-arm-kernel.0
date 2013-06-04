From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  4 Jun 2013 02:02:21 -0300
Subject: [PATCH v2 1/2] ARM: dts: mx28: Adjust the digctl compatible string
Message-ID: <1370322142-23926-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

MX28 has the same DIGCTL block as MX23, so adjust the compatible string to
reflect that.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- None. Newly introduced in this series

 arch/arm/boot/dts/imx28.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 62fb4a2..095e50b 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -702,7 +702,7 @@
 			};
 
 			digctl at 8001c000 {
-				compatible = "fsl,imx28-digctl";
+				compatible = "fsl,imx28-digctl", "fsl,imx23-digctl";
 				reg = <0x8001c000 0x2000>;
 				interrupts = <89>;
 				status = "disabled";
-- 
1.8.1.2
