From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 21 May 2014 19:43:30 +0200
Subject: [PATCH 1/2] ARM: dts: sun7i: cubietruck: set mmc3 bus-width property
Message-ID: <1400694211-29903-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bus-width defaults to 1, and all 4 lines are hooked up at the cubietruck,
properly set bus-width to 4.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 765191d..70271f6 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -34,6 +34,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc3_pins_a>;
 			vmmc-supply = <&reg_vmmc3>;
+			bus-width = <4>;
 			non-removable;
 			status = "okay";
 		};
-- 
1.9.0
