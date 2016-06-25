From: stefan@agner.ch (Stefan Agner)
Date: Sat, 25 Jun 2016 16:19:05 -0700
Subject: [PATCH] ARM: dts: vf-colibri: specify panel supply
Message-ID: <20160625231905.4721-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The display panel is powered by the Carrier board's 3.3V rail.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
index a8a8e43..f900b46 100644
--- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
@@ -53,6 +53,7 @@
 	panel: panel {
 		compatible = "edt,et057090dhu";
 		backlight = <&bl>;
+		power-supply = <&reg_3v3>;
 	};
 
 	reg_3v3: regulator-3v3 {
-- 
2.8.3
