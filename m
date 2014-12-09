From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  9 Dec 2014 12:25:02 +0100
Subject: [PATCH 4/7] ARM: shmobile: henninger dts: Replace status value "ok"
 by "okay"
In-Reply-To: <1418124305-7445-1-git-send-email-geert+renesas@glider.be>
References: <1418124305-7445-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1418124305-7445-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While the DT parsing code recognizes "ok" as a valid value for the
"status" property, ePAPR v1.1 doesn't mention it in the list of valid
values.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791-henninger.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-henninger.dts b/arch/arm/boot/dts/r8a7791-henninger.dts
index 740e38678032a7ac..d2ebf11f98814ab5 100644
--- a/arch/arm/boot/dts/r8a7791-henninger.dts
+++ b/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -156,7 +156,7 @@
 
 	phy-handle = <&phy1>;
 	renesas,ether-link-active-low;
-	status = "ok";
+	status = "okay";
 
 	phy1: ethernet-phy at 1 {
 		reg = <1>;
@@ -293,7 +293,7 @@
 
 /* composite video input */
 &vin0 {
-	status = "ok";
+	status = "okay";
 	pinctrl-0 = <&vin0_pins>;
 	pinctrl-names = "default";
 
-- 
1.9.1
