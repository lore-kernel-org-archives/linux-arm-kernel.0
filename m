From: hdegoede@redhat.com (Hans de Goede)
Date: Wed,  1 Oct 2014 09:26:04 +0200
Subject: [PATCH v2 1/3] ARM: dts: sun7i: Add spi0_pins_a pinctrl setting
In-Reply-To: <1412148366-18346-1-git-send-email-hdegoede@redhat.com>
References: <1412148366-18346-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1412148366-18346-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index b22daf3..cb5abef 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -784,6 +784,13 @@
 				allwinner,pull = <0>;
 			};
 
+			spi0_pins_a: spi0 at 0 {
+				allwinner,pins = "PI10", "PI11", "PI12", "PI13", "PI14";
+				allwinner,function = "spi0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			spi1_pins_a: spi1 at 0 {
 				allwinner,pins = "PI16", "PI17", "PI18", "PI19";
 				allwinner,function = "spi1";
-- 
2.1.0
