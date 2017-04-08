From: dev@lynxeye.de (Lucas Stach)
Date: Sat,  8 Apr 2017 16:36:06 +0200
Subject: [RFC PATCH 6/7] ARM: dts: imx6*-hummingboard2: remove redundant PWM
 disables
In-Reply-To: <20170408143607.15928-1-dev@lynxeye.de>
References: <20170408143607.15928-1-dev@lynxeye.de>
Message-ID: <20170408143607.15928-7-dev@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PWM nodes are already disabled in the imx6qdl.dtsi, so there
is no need to disable them again in the board DTS.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index 31a029c..892259f 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -482,14 +482,6 @@
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
2.9.3
