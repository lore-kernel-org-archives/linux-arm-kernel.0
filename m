From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 27 Nov 2017 16:53:01 +0000
Subject: [PATCH 11/13] ARM: dts: imx6qdl-hummingboard: fix node names
In-Reply-To: <20171127165134.GH31757@n2100.armlinux.org.uk>
References: <20171127165134.GH31757@n2100.armlinux.org.uk>
Message-ID: <E1eJMeT-0002rf-5D@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Node names are supposed to be generic, fix the RTC and codec node
names.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index 66bda5a04582..92583238ca4a 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -150,13 +150,13 @@
 	status = "okay";
 
 	/* Pro baseboard model */
-	rtc: pcf8523 at 68 {
+	rtc at 68 {
 		compatible = "nxp,pcf8523";
 		reg = <0x68>;
 	};
 
 	/* Pro baseboard model */
-	sgtl5000: sgtl5000 at a {
+	sgtl5000: codec at a {
 		clocks = <&clks IMX6QDL_CLK_CKO>;
 		compatible = "fsl,sgtl5000";
 		pinctrl-names = "default";
-- 
2.7.4
