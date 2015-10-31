From: mweseloh42@gmail.com (Marcus Weseloh)
Date: Sat, 31 Oct 2015 13:55:42 +0100
Subject: [PATCH] ARM: dts: sun4i: Enable audio codec on Olimex A20-SOM-EVB
Message-ID: <1446296142-4152-1-git-send-email-mweseloh42@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the on-chip audio codec on the Olimex A20-SOM-EVB

Signed-off-by: Marcus Weseloh <mweseloh42@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
index b7fe102..03352cc 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
@@ -86,6 +86,10 @@
 	status = "okay";
 };
 
+&codec {
+        status = "okay";
+};
+
 &gmac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&gmac_pins_rgmii_a>;
-- 
1.9.1
