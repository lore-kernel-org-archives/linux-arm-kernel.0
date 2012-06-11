From: stigge@antcom.de (Roland Stigge)
Date: Mon, 11 Jun 2012 21:09:44 +0200
Subject: [PATCH] ARM: omap: Fix dts files w/ status property: "disable" ->
 "disabled"
Message-ID: <1339441785-14641-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches fixes some status = "disable" strings to "disabled", the correct
way of disabling nodes in the devicetree.

Just the OMAP part here, the rest goes via other patches and trees.

Signed-off-by: Roland Stigge <stigge@antcom.de>
Acked-by: Rob Herring <rob.herring@calxeda.com>

---
Applies to v3.5-rc2

 arch/arm/boot/dts/omap3-beagle.dts |    4 +--
 arch/arm/boot/dts/omap4-panda.dts  |    6 ++---
 arch/arm/boot/dts/omap4-sdp.dts    |    4 +--
 arch/arm/boot/dts/tegra20.dtsi     |   36 +++++++++++++++++------------------
 arch/arm/boot/dts/tegra30.dtsi     |   38 ++++++++++++++++++-------------------
 5 files changed, 44 insertions(+), 44 deletions(-)

--- linux-2.6.orig/arch/arm/boot/dts/omap3-beagle.dts
+++ linux-2.6/arch/arm/boot/dts/omap3-beagle.dts
@@ -61,9 +61,9 @@
 };
 
 &mmc2 {
-	status = "disable";
+	status = "disabled";
 };
 
 &mmc3 {
-	status = "disable";
+	status = "disabled";
 };
--- linux-2.6.orig/arch/arm/boot/dts/omap4-panda.dts
+++ linux-2.6/arch/arm/boot/dts/omap4-panda.dts
@@ -74,15 +74,15 @@
 };
 
 &mmc2 {
-	status = "disable";
+	status = "disabled";
 };
 
 &mmc3 {
-	status = "disable";
+	status = "disabled";
 };
 
 &mmc4 {
-	status = "disable";
+	status = "disabled";
 };
 
 &mmc5 {
--- linux-2.6.orig/arch/arm/boot/dts/omap4-sdp.dts
+++ linux-2.6/arch/arm/boot/dts/omap4-sdp.dts
@@ -147,11 +147,11 @@
 };
 
 &mmc3 {
-	status = "disable";
+	status = "disabled";
 };
 
 &mmc4 {
-	status = "disable";
+	status = "disabled";
 };
 
 &mmc5 {
