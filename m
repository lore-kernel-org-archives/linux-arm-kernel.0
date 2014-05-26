From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 26 May 2014 10:40:31 +0200
Subject: [PATCH] ARM: dts: imx6qdl-gw5xxx: Fix Linear Technology vendor prefix
Message-ID: <1401093631-18467-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vendor prefix for Linear Technology should be lltc,
same as the NASDAQ symbol.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi | 2 +-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 2 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
index 98a4221..642d909 100644
--- a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
@@ -156,7 +156,7 @@
 	status = "okay";
 
 	pmic: ltc3676 at 3c {
-		compatible = "ltc,ltc3676";
+		compatible = "lltc,ltc3676";
 		reg = <0x3c>;
 
 		regulators {
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 8e99c9a..f5adbd2 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -208,7 +208,7 @@
 	};
 
 	pmic: ltc3676 at 3c {
-		compatible = "ltc,ltc3676";
+		compatible = "lltc,ltc3676";
 		reg = <0x3c>;
 
 		regulators {
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index c8e5ae0..c371ba1 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -222,7 +222,7 @@
 	};
 
 	pmic: ltc3676 at 3c {
-		compatible = "ltc,ltc3676";
+		compatible = "lltc,ltc3676";
 		reg = <0x3c>;
 
 		regulators {
-- 
2.0.0.rc2
