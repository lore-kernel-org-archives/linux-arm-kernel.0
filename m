From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Thu, 28 Jun 2018 18:36:39 +0200
Subject: [PATCHv2 2/2] ARM: dts: imx53: PPD: Rename usbphy nodes
In-Reply-To: <20180628163639.1078-1-sebastian.reichel@collabora.co.uk>
References: <20180628163639.1078-1-sebastian.reichel@collabora.co.uk>
Message-ID: <20180628163639.1078-2-sebastian.reichel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This renames usbphy nodes 2 & 3, so that they follow the same
format as usbphy node 0 & 1 from imx53.dtsi.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/imx53-ppd.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
index daed979b6e40..f3a02481ce14 100644
--- a/arch/arm/boot/dts/imx53-ppd.dts
+++ b/arch/arm/boot/dts/imx53-ppd.dts
@@ -218,7 +218,7 @@
 		};
 	};
 
-	usbphy2: usbphy2 {
+	usbphy2: usbphy-2 {
 		compatible = "usb-nop-xceiv";
 		vcc-supply = <&reg_3v3>;
 		reset-gpios = <&gpio4 4 GPIO_ACTIVE_LOW>;
@@ -229,7 +229,7 @@
 		assigned-clock-parents = <&clks IMX5_CLK_OSC>;
 	};
 
-	usbphy3: usbphy3 {
+	usbphy3: usbphy-3 {
 		compatible = "usb-nop-xceiv";
 		vcc-supply = <&reg_3v3>;
 		reset-gpios = <&gpio2 19 GPIO_ACTIVE_LOW>;
-- 
2.18.0
