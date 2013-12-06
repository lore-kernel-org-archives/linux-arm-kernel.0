From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri,  6 Dec 2013 21:20:31 +0100
Subject: [PATCH] ARM: dts: mxs: add #io-channel-cells to mx28 lradc
Message-ID: <1386361231-20427-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/imx28.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index cda19c8b0a47..92d9f9e33bf1 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -945,6 +945,7 @@
 						20 21 22 23 24 25>;
 				status = "disabled";
 				clocks = <&clks 41>;
+				#io-channel-cells = <1>;
 			};
 
 			spdif: spdif at 80054000 {
-- 
1.8.3.2
