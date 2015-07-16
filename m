From: aalonso@freescale.com (Adrian Alonso)
Date: Thu, 16 Jul 2015 15:34:45 -0500
Subject: [PATCH 2/4][v4] ARM: dts: imx: imx7d add iomuxc lpsr register base
 address
In-Reply-To: <1437078887-2524-1-git-send-email-aalonso@freescale.com>
References: <1437078887-2524-1-git-send-email-aalonso@freescale.com>
Message-ID: <1437078887-2524-2-git-send-email-aalonso@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Add iomuxc lpsr register base address to extend
  pinctrl-imx driver to support the iomux settings for pins
  that support LPSR operation mode.

Signed-off-by: Adrian Alonso <aalonso@freescale.com>
---
- Version 2: Resend
- Version 3: Resend
- Version 4: Resend

 arch/arm/boot/dts/imx7d.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 9014b80..7edfa42 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -487,7 +487,7 @@
 
 			iomuxc: iomuxc at 30330000 {
 				compatible = "fsl,imx7d-iomuxc";
-				reg = <0x30330000 0x10000>;
+				reg = <0x30330000 0x10000>, <0x302c0000 0x10000>;
 			};
 
 			gpr: iomuxc-gpr at 30340000 {
-- 
2.1.4
