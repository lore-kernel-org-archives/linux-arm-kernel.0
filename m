From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 26 Apr 2014 08:52:06 +0400
Subject: [PATCH 1/8] ARM: dts: imx27-phytec-phycore-rdk: Remove duplicate
 entries for USB PHY
Message-ID: <1398487933-5683-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"compatible", "#address-cells" and "#size-cells" for USB PHY are
already described in the SOM DTS. Remove these duplicate entries.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index 0875327..ac18ccf 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -39,10 +39,6 @@
 	};
 
 	usbphy {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
 		usbphy2: usbphy at 2 {
 			compatible = "usb-nop-xceiv";
 			reg = <0>;
-- 
1.8.3.2
