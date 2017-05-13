From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sat, 13 May 2017 16:33:22 +0200
Subject: [PATCH v2 03/18] arm64: dts: meson-gxbb-vega-s95: Fix Wifi node name
In-Reply-To: <20170513143337.14278-1-afaerber@suse.de>
References: <20170513143337.14278-1-afaerber@suse.de>
Message-ID: <20170513143337.14278-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bcrmf -> brcmf -> wifi

Fixes: ab5b24fdd2d5 ("ARM64: dts: meson-gxbb-vega-s95: Add SD/SDIO/MMC and PWM nodes")
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2:
 * Renamed node brmcf -> wifi (Rob)
 
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index aefa66dff72d..f4bfee8e2e08 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -186,7 +186,7 @@
 	vmmc-supply = <&vcc_3v3>;
 	vqmmc-supply = <&vcc_1v8>;
 
-	brcmf: bcrmf at 1 {
+	brcmf: wifi at 1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 	};
-- 
2.12.0
