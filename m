From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 21 May 2017 18:16:55 -0300
Subject: [PATCH] ARM: dts: sunxi: Fix BCM43xx node name
Message-ID: <1495401415-14477-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

"bcrmf" is a typo and "wifi" is the preferred form to describe
such node, so change it accordingly.

Reported-by: Andreas F?rber <afaerber@suse.de>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Based on the following dt documentation commit:
https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?h=dt/next&id=442e1f7eb8e6858408a7ad58bb10813c19877ae5

 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts | 2 +-
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts | 2 +-
 arch/arm/boot/dts/sun7i-a20-bananapro.dts        | 2 +-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts       | 2 +-
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts        | 2 +-
 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts | 2 +-
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts  | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
index bdfdce8..51e6f1d 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
@@ -138,7 +138,7 @@
 	non-removable;
 	status = "okay";
 
-	brcmf: bcrmf at 1 {
+	brcmf: wifi at 1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&r_pio>;
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
index 08e776a..4c03cc3 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
@@ -172,7 +172,7 @@
 	wakeup-source;
 	status = "okay";
 
-	brcmf: bcrmf at 1 {
+	brcmf: wifi at 1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&pio>;
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapro.dts b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
index 83516bc..e7af1b7 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
@@ -172,7 +172,7 @@
 	non-removable;
 	status = "okay";
 
-	brcmf: bcrmf at 1 {
+	brcmf: wifi at 1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&pio>;
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 4ebeecf..8dbf732 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -195,7 +195,7 @@
 	non-removable;
 	status = "okay";
 
-	brcmf: bcrmf at 1 {
+	brcmf: wifi at 1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&pio>;
diff --git a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
index e5cbcad..5580997 100644
--- a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
@@ -173,7 +173,7 @@
 	non-removable;
 	status = "okay";
 
-	brcmf: bcrmf at 1 {
+	brcmf: wifi at 1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&pio>;
diff --git a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
index 84462d7..7f8405a 100644
--- a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
+++ b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
@@ -137,7 +137,7 @@
 	non-removable;
 	status = "okay";
 
-	brcmf: bcrmf at 1 {
+	brcmf: wifi at 1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&pio>;
diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index 17c7c08..883072b 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -130,7 +130,7 @@
 	non-removable;
 	status = "okay";
 
-	brcmf: bcrmf at 1 {
+	brcmf: wifi at 1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&pio>;
-- 
2.7.4
