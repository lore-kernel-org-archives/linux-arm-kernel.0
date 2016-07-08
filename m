From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  8 Jul 2016 18:05:46 +0200
Subject: [PATCH 05/15] ARM: dts: sun5i: reference-design-tablet: Remove
 mention of q8
In-Reply-To: <1467993956-19535-1-git-send-email-hdegoede@redhat.com>
References: <1467993956-19535-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1467993956-19535-6-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove all mention of q8 from sun5i-reference-design-tablet.dtsi.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
index e78452c..20cc940 100644
--- a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
@@ -98,7 +98,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_q8>;
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 0 GPIO_ACTIVE_HIGH>; /* PG0 */
@@ -118,7 +118,7 @@
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
-	mmc0_cd_pin_q8: mmc0_cd_pin at 0 {
+	mmc0_cd_pin: mmc0_cd_pin at 0 {
 		allwinner,pins = "PG0";
 		allwinner,function = "gpio_in";
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-- 
2.7.4
