From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 20 Apr 2016 17:32:09 +0200
Subject: [PATCH 04/14] ARM: dts: OMAP36xx: : DT spelling
 s/#address-cell/#address-cells/
In-Reply-To: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1461166339-11109-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/omap36xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index ce1e242d4dc07ea8..8b797915300894d8 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -44,7 +44,7 @@
 		abb_mpu_iva: regulator-abb-mpu {
 			compatible = "ti,abb-v1";
 			regulator-name = "abb_mpu_iva";
-			#address-cell = <0>;
+			#address-cells = <0>;
 			#size-cells = <0>;
 			reg = <0x483072f0 0x8>, <0x48306818 0x4>;
 			reg-names = "base-address", "int-address";
-- 
1.9.1
