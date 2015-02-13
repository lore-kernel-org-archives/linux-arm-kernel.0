From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Fri, 13 Feb 2015 15:12:05 +0100
Subject: [PATCH 5/5] ARM: dts: imx28-apf28dev: add support for auart0
In-Reply-To: <1423836725-86061-4-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1423836725-86061-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <1423836725-86061-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <1423836725-86061-3-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <1423836725-86061-4-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <1423836725-86061-5-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
Signed-off-by: Sebastien Szymanski <sebastien.szymanski@armadeus.com>
---
 arch/arm/boot/dts/imx28-apf28dev.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
index a052d3e..81e5f75 100644
--- a/arch/arm/boot/dts/imx28-apf28dev.dts
+++ b/arch/arm/boot/dts/imx28-apf28dev.dts
@@ -137,6 +137,13 @@
 				status = "okay";
 			};
 
+			auart0: serial at 8006a000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&auart0_pins_a>;
+				fsl,uart-has-rtscts;
+				status = "okay";
+			};
+
 			usbphy0: usbphy at 8007c000 {
 				status = "okay";
 			};
-- 
2.0.5
