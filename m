From: tony@atomide.com (Tony Lindgren)
Date: Tue, 22 Dec 2015 08:01:15 -0800
Subject: [PATCH] ARM: dts: The rate for auxclk is 22.59792 by default
Message-ID: <1450800075-10108-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rate for auxclk is 22.59792 by default.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm814x-clocks.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dm814x-clocks.dtsi b/arch/arm/boot/dts/dm814x-clocks.dtsi
index 2600158..e0ea6a9 100644
--- a/arch/arm/boot/dts/dm814x-clocks.dtsi
+++ b/arch/arm/boot/dts/dm814x-clocks.dtsi
@@ -41,11 +41,11 @@
 		reg = <0x0040>;
 	};
 
-	/* Optional auxosc, 20 - 30 MHz range, assume 27 MHz by default */
+	/* Optional auxosc, 20 - 30 MHz range, assume 22.5729 MHz by default */
 	auxosc_ck: auxosc_ck {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
-		clock-frequency = <27000000>;
+		clock-frequency = <22572900>;
 	};
 
 	/* Optional 32768Hz crystal or clock on RTCOSC pins */
-- 
2.6.2
