From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 26 Apr 2014 08:52:11 +0400
Subject: [PATCH 6/8] ARM: dts: imx27-phytec-phycore-rdk: Fix "reg" property
 for USBH2 PHY
In-Reply-To: <1398487933-5683-1-git-send-email-shc_work@mail.ru>
References: <1398487933-5683-1-git-send-email-shc_work@mail.ru>
Message-ID: <1398487933-5683-6-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index 72c773e..d0b693f 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -55,7 +55,7 @@
 	usbphy {
 		usbphy2: usbphy at 2 {
 			compatible = "usb-nop-xceiv";
-			reg = <0>;
+			reg = <2>;
 			vcc-supply = <&reg_5v0>;
 			clocks = <&clks 0>;
 			clock-names = "main_clk";
-- 
1.8.3.2
