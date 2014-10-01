From: hdegoede@redhat.com (Hans de Goede)
Date: Wed,  1 Oct 2014 16:25:36 +0200
Subject: [PATCH 1/2] ARM: dts: sun7i: Add mmc2_pins_a pinctrl definition
Message-ID: <1412173537-8538-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 302dc1f..a323621 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -833,6 +833,13 @@
 				allwinner,pull = <1>;
 			};
 
+			mmc2_pins_a: mmc2 at 0 {
+				allwinner,pins = "PC6","PC7","PC8","PC9","PC10","PC11";
+				allwinner,function = "mmc2";
+				allwinner,drive = <2>;
+				allwinner,pull = <1>;
+			};
+
 			mmc3_pins_a: mmc3 at 0 {
 				allwinner,pins = "PI4","PI5","PI6","PI7","PI8","PI9";
 				allwinner,function = "mmc3";
-- 
2.1.0
