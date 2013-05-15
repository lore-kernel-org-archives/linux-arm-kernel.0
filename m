From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 15 May 2013 12:12:41 +0530
Subject: [PATCH] ARM: dts: omap3 beagle: Add usb otg hs dt data
Message-ID: <1368600161-10351-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added board specific dt data for omap3 beagle in omap3-beagle.dts
file.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap3-beagle.dts |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 6eec699..02bf5d0 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -142,3 +142,10 @@
 	 */
 	ti,pulldowns = <0x03a1c4>;
 };
+
+&usb_otg_hs {
+        interface-type = <0>;
+        usb-phy = <&usb2_phy>;
+        mode = <3>;
+        power = <50>;
+};
-- 
1.7.10.4
