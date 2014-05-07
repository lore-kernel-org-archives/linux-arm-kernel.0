From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed,  7 May 2014 15:31:25 +0200
Subject: [PATCH 2/6] ARM: dts: i.MX25: remove disabled property of usbmisc unit
In-Reply-To: <1399469489-22788-1-git-send-email-s.hauer@pengutronix.de>
References: <1399469489-22788-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1399469489-22788-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's a unit only used by the usb devices. No need to enable them
manually.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx25.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 680486a..399b25b 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -520,7 +520,6 @@
 				clocks = <&clks 9>, <&clks 70>, <&clks 8>;
 				clock-names = "ipg", "ahb", "per";
 				reg = <0x53ff4600 0x00f>;
-				status = "disabled";
 			};
 
 			dryice at 53ffc000 {
-- 
2.0.0.rc0
