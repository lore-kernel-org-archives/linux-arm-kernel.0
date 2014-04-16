From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 16 Apr 2014 11:24:57 +0400
Subject: [PATCH 8/8] ARM: dts: imx51-babbage: Use predefined constants for
 clock definition
In-Reply-To: <1397633097-1640-1-git-send-email-shc_work@mail.ru>
References: <1397633097-1640-1-git-send-email-shc_work@mail.ru>
Message-ID: <1397633097-1640-8-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51-babbage.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 5a50bbf..e9ce0c0 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -170,7 +170,7 @@
 		usbh1phy: usbh1phy at 0 {
 			compatible = "usb-nop-xceiv";
 			reg = <0>;
-			clocks = <&clks 0>;
+			clocks = <&clks IMX5_CLK_DUMMY>;
 			clock-names = "main_clk";
 		};
 	};
-- 
1.8.3.2
