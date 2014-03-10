From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 10 Mar 2014 17:54:40 -0300
Subject: [PATCH 2/7] ARM: dts: mx25: Add USB PHY nodes
In-Reply-To: <1394484885-21262-1-git-send-email-festevam@gmail.com>
References: <1394484885-21262-1-git-send-email-festevam@gmail.com>
Message-ID: <1394484885-21262-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add the USB PHY nodes for the USB Host1 and OTG ports.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx25.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 6088059..12e8a94 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -499,6 +499,7 @@
 				clocks = <&clks 9>, <&clks 70>, <&clks 8>;
 				clock-names = "ipg", "ahb", "per";
 				fsl,usbmisc = <&usbmisc 0>;
+				fsl,usbphy = <&usbphy1>;
 				status = "disabled";
 			};
 
@@ -509,6 +510,7 @@
 				clocks = <&clks 9>, <&clks 70>, <&clks 8>;
 				clock-names = "ipg", "ahb", "per";
 				fsl,usbmisc = <&usbmisc 1>;
+				fsl,usbphy = <&usbphy2>;
 				status = "disabled";
 			};
 
-- 
1.8.1.2
