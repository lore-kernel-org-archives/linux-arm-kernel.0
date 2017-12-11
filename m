From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 11 Dec 2017 16:58:29 +0000
Subject: [PATCH 14/20] ARM: dts: imx6*-hummingboard2: remove redundant PWM
 disables
In-Reply-To: <20171211165631.GW10595@n2100.armlinux.org.uk>
References: <20171211165631.GW10595@n2100.armlinux.org.uk>
Message-ID: <E1eORPR-0000IQ-8K@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lucas Stach <dev@lynxeye.de>

The PWM nodes are already disabled in the imx6qdl.dtsi, so there
is no need to disable them again in the board DTS.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index 2a63c992b62c..6fbfa970a0a7 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -478,14 +478,6 @@
 	status = "okay";
 };
 
-&pwm3 {
-	status = "disabled";
-};
-
-&pwm4 {
-	status = "disabled";
-};
-
 &ssi1 {
 	status = "okay";
 };
-- 
2.7.4
