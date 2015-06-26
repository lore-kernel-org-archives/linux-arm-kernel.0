From: walter@vanguardiasur.com.ar (Walter Lozano)
Date: Thu, 25 Jun 2015 23:25:58 -0300
Subject: [PATCH 2/3] ARM: socfpga: dts: Fix entries order
In-Reply-To: <1435285559-11053-1-git-send-email-walter@vanguardiasur.com.ar>
References: <1435285559-11053-1-git-send-email-walter@vanguardiasur.com.ar>
Message-ID: <1435285559-11053-2-git-send-email-walter@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch reorders the nodes alphabetically

Signed-off-by: Walter Lozano <walter@vanguardiasur.com.ar>
---
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
index 5b60692..d343e03 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
@@ -60,15 +60,6 @@
 	rxc-skew-ps = <2000>;
 };
 
-&mmc0 {
-	vmmc-supply = <&regulator_3_3v>;
-	vqmmc-supply = <&regulator_3_3v>;
-};
-
-&usb1 {
-	status = "okay";
-};
-
 &gpio2 {
 	status = "okay";
 };
@@ -84,3 +75,12 @@
 		interrupts = <3 2>;
 	};
 };
+
+&mmc0 {
+	vmmc-supply = <&regulator_3_3v>;
+	vqmmc-supply = <&regulator_3_3v>;
+};
+
+&usb1 {
+	status = "okay";
+};
-- 
1.7.10.4
