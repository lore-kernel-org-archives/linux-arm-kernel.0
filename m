From: marek@goldelico.com (Marek Belisko)
Date: Sat, 11 Jan 2014 22:11:14 +0100
Subject: [PATCH] ARM: dts: twl4030: Add power support.
Message-ID: <1389474674-4179-1-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/twl4030.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
index 4217096..21079e1 100644
--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -25,6 +25,10 @@
 		bci3v1-supply = <&vusb3v1>;
 	};
 
+	twl_power: power {
+		compatible = "ti,twl4030-power";
+	};
+
 	watchdog {
 		compatible = "ti,twl4030-wdt";
 	};
-- 
1.8.4.2
