From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 10 Mar 2014 17:54:41 -0300
Subject: [PATCH 3/7] ARM: dts: mx25: Let usbmisc be enabled by default
In-Reply-To: <1394484885-21262-1-git-send-email-festevam@gmail.com>
References: <1394484885-21262-1-git-send-email-festevam@gmail.com>
Message-ID: <1394484885-21262-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Like it is done on other imx SoCs, let usbmisc be enabled by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx25.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 12e8a94..a69fd46 100644
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
1.8.1.2
