From: aalonso@freescale.com (Adrian Alonso)
Date: Tue, 7 Jul 2015 14:17:08 -0500
Subject: [PATCH 2/4][v3] ARM: dts: imx: imx7d add iomuxc lpsr register base
 address
In-Reply-To: <1436296630-20296-1-git-send-email-aalonso@freescale.com>
References: <1436296630-20296-1-git-send-email-aalonso@freescale.com>
Message-ID: <1436296630-20296-2-git-send-email-aalonso@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Add iomuxc lpsr register base address to extend
  pinctrl-imx driver to support the iomux settings for pins
  that support LPSR operation mode.

Signed-off-by: Adrian Alonso <aalonso@freescale.com>

- Change v1 to v3: resend patch

---
 arch/arm/boot/dts/imx7d.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index c42cf8d..294a6c6 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -253,7 +253,7 @@
 
 			iomuxc: iomuxc at 30330000 {
 				compatible = "fsl,imx7d-iomuxc";
-				reg = <0x30330000 0x10000>;
+				reg = <0x30330000 0x10000>, <0x302c0000 0x10000>;
 			};
 
 			gpr: iomuxc-gpr at 30340000 {
-- 
2.1.4
