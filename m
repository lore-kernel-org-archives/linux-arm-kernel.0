From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 31 Jul 2013 16:37:58 +0200
Subject: [PATCH 8/10] ARM: dts: mxs: add 'phy_type' property to usbphy nodes
In-Reply-To: <1375281480-25775-1-git-send-email-LW@KARO-electronics.de>
References: <1375281480-25775-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1375281480-25775-8-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx28.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 2387d46..d9bf387 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -1044,6 +1044,7 @@
 				compatible = "fsl,imx28-usbphy", "fsl,imx23-usbphy";
 				reg = <0x8007c000 0x2000>;
 				clocks = <&clks 62>;
+				phy_type = "utmi";
 				status = "disabled";
 			};
 
@@ -1051,6 +1052,7 @@
 				compatible = "fsl,imx28-usbphy", "fsl,imx23-usbphy";
 				reg = <0x8007e000 0x2000>;
 				clocks = <&clks 63>;
+				phy_type = "utmi";
 				status = "disabled";
 			};
 		};
-- 
1.7.2.5
