From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 21 Aug 2017 18:06:34 +0200
Subject: [PATCH v2 6/9] ARM64: dts: meson-gxl: libretech-cc: remove sdr104
 capability
In-Reply-To: <20170821160637.22456-1-jbrunet@baylibre.com>
References: <20170821160637.22456-1-jbrunet@baylibre.com>
Message-ID: <20170821160637.22456-7-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unfortunately, the PCB of the libretech-cc cannot handle sdcard
at 200Mhz reliably, so sdr104 is removed

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 0537b92cd226..a582152f5e63 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -145,7 +145,6 @@
 	sd-uhs-sdr12;
 	sd-uhs-sdr25;
 	sd-uhs-sdr50;
-	sd-uhs-sdr104;
 	max-frequency = <100000000>;
 	disable-wp;
 
-- 
2.9.5
