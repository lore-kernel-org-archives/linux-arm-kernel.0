From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed,  7 Sep 2016 17:13:42 +0200
Subject: [PATCH 6/7] ARM64: dts: amlogic: add pins for spifc
In-Reply-To: <1473261223-15412-1-git-send-email-jbrunet@baylibre.com>
References: <1473261223-15412-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1473261223-15412-7-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 762f368..b35fc94 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -333,6 +333,16 @@
 					};
 				};
 
+				spifc_pins: spifc {
+					mux {
+						groups = "spifc_d",
+						       "spifc_q",
+						       "spifc_c",
+						       "spifc_cs";
+						function = "spifc";
+					};
+				};
+
 				sdcard_pins: sdcard {
 					mux {
 						groups = "sdcard_d0",
-- 
2.7.4
