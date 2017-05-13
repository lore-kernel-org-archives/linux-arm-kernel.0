From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sat, 13 May 2017 16:33:23 +0200
Subject: [PATCH v2 04/18] arm64: dts: meson-gxbb-p20x: Fix Wifi node name
In-Reply-To: <20170513143337.14278-1-afaerber@suse.de>
References: <20170513143337.14278-1-afaerber@suse.de>
Message-ID: <20170513143337.14278-5-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bcrmf -> brcmf -> wifi

Fixes: ab3943fe57a2 ("ARM64: dts: meson-gxbb: Add P20x Wifi SDIO support")
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2:
 * Renamed node brmcf -> wifi (Rob)
 
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index 3c6c0b7f4187..a5be438a5c03 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -198,7 +198,7 @@
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_boot>;
 
-	brcmf: bcrmf at 1 {
+	brcmf: wifi at 1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 	};
-- 
2.12.0
