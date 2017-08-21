From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 21 Aug 2017 18:06:36 +0200
Subject: [PATCH v2 8/9] ARM64: dts: meson-gxbb: nanopi-k2: enable sdcard UHS
 modes
In-Reply-To: <20170821160637.22456-1-jbrunet@baylibre.com>
References: <20170821160637.22456-1-jbrunet@baylibre.com>
Message-ID: <20170821160637.22456-9-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable UHS modes, up to SDR50, on the nanopi-k2 SBC.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index de4ed28d78bc..38630871c2ea 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -227,6 +227,9 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
 	max-frequency = <100000000>;
 	disable-wp;
 
-- 
2.9.5
