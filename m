From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri,  4 Aug 2017 20:08:14 +0200
Subject: [PATCH 4/6] ARM64: dts: meson-gxbb: nanopi-k2: enable sdcard UHS modes
In-Reply-To: <20170804180816.18737-1-jbrunet@baylibre.com>
References: <20170804180816.18737-1-jbrunet@baylibre.com>
Message-ID: <20170804180816.18737-5-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index 6b7495dc6014..5d59fd75cae7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -225,7 +225,10 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	max-frequency = <100000000>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	max-frequency = <200000000>;
 	disable-wp;
 
 	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-- 
2.9.4
