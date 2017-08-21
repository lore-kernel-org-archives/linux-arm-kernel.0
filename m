From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 21 Aug 2017 18:06:37 +0200
Subject: [PATCH v2 9/9] ARM64: dts: meson-gxbb: nanopi-k2: enable sdr104 mode
In-Reply-To: <20170821160637.22456-1-jbrunet@baylibre.com>
References: <20170821160637.22456-1-jbrunet@baylibre.com>
Message-ID: <20170821160637.22456-10-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SDR104 seems to be OK on the nanopi-k2 SBC so enable it

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index 38630871c2ea..eb08bc1623f7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -230,7 +230,8 @@
 	sd-uhs-sdr12;
 	sd-uhs-sdr25;
 	sd-uhs-sdr50;
-	max-frequency = <100000000>;
+	sd-uhs-sdr104;
+	max-frequency = <200000000>;
 	disable-wp;
 
 	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-- 
2.9.5
