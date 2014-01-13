From: b20788@freescale.com (Anson Huang)
Date: Mon, 13 Jan 2014 13:58:37 +0800
Subject: [PATCH V3 4/5] ARM: dts: imx6sl: add compatible name for i.mx6q
In-Reply-To: <1389592718-9999-1-git-send-email-b20788@freescale.com>
References: <1389592718-9999-1-git-send-email-b20788@freescale.com>
Message-ID: <1389592718-9999-4-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add compatible name of i.mx6q for those reuse modules.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/boot/dts/imx6sl.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index a5ef3c3..5fbf42d 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -564,7 +564,7 @@
 			};
 
 			src: src at 020d8000 {
-				compatible = "fsl,imx6sl-src", "fsl,imx51-src";
+				compatible = "fsl,imx6sl-src", "fsl,imx6q-src", "fsl,imx51-src";
 				reg = <0x020d8000 0x4000>;
 				interrupts = <0 91 IRQ_TYPE_LEVEL_HIGH>,
 					     <0 96 IRQ_TYPE_LEVEL_HIGH>;
@@ -584,7 +584,7 @@
 			};
 
 			iomuxc: iomuxc at 020e0000 {
-				compatible = "fsl,imx6sl-iomuxc";
+				compatible = "fsl,imx6sl-iomuxc", "fsl,imx6q-iomuxc";
 				reg = <0x020e0000 0x4000>;
 			};
 
-- 
1.7.9.5
