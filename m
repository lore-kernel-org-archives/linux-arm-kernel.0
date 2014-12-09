From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  9 Dec 2014 12:25:01 +0100
Subject: [PATCH 3/7] ARM: shmobile: lager dts: Replace status value "ok" by
 "okay"
In-Reply-To: <1418124305-7445-1-git-send-email-geert+renesas@glider.be>
References: <1418124305-7445-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1418124305-7445-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While the DT parsing code recognizes "ok" as a valid value for the
"status" property, ePAPR v1.1 doesn't mention it in the list of valid
values.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 4118030f366dfa7d..59365bccc9450c6c 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -355,7 +355,7 @@
 
 	phy-handle = <&phy1>;
 	renesas,ether-link-active-low;
-	status = "ok";
+	status = "okay";
 
 	phy1: ethernet-phy at 1 {
 		reg = <1>;
@@ -366,7 +366,7 @@
 };
 
 &cmt0 {
-	status = "ok";
+	status = "okay";
 };
 
 &mmcif1 {
@@ -470,17 +470,17 @@
 };
 
 &iic0	{
-	status = "ok";
+	status = "okay";
 };
 
 &iic1	{
-	status = "ok";
+	status = "okay";
 	pinctrl-0 = <&iic1_pins>;
 	pinctrl-names = "default";
 };
 
 &iic2	{
-	status = "ok";
+	status = "okay";
 	pinctrl-0 = <&iic2_pins>;
 	pinctrl-names = "default";
 
@@ -562,7 +562,7 @@
 	pinctrl-0 = <&vin1_pins>;
 	pinctrl-names = "default";
 
-	status = "ok";
+	status = "okay";
 
 	port {
 		#address-cells = <1>;
-- 
1.9.1
