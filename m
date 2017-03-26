From: jbrunet@baylibre.com (Jerome Brunet)
Date: Sun, 26 Mar 2017 19:19:21 +0200
Subject: [PATCH v2 6/8] ARM64: dts: meson-gxbb: add spdif output pins
In-Reply-To: <20170326171923.19269-1-jbrunet@baylibre.com>
References: <20170326171923.19269-1-jbrunet@baylibre.com>
Message-ID: <20170326171923.19269-7-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add EE and AO domains pins for the spdif output to the gxbb device tree.

Acked-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index a9cacbd6a1d6..d1dc6a49df13 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -234,6 +234,20 @@
 				function = "i2s_out_ao";
 			};
 		};
+
+		spdif_out_ao_6_pins: spdif_out_ao_6 {
+			mux {
+				groups = "spdif_out_ao_6";
+				function = "spdif_out_ao";
+			};
+		};
+
+		spdif_out_ao_13_pins: spdif_out_ao_13 {
+			mux {
+				groups = "spdif_out_ao_13";
+				function = "spdif_out_ao";
+			};
+		};
 	};
 };
 
@@ -495,6 +509,13 @@
 				function = "i2s_out";
 			};
 		};
+
+		spdif_out_y_pins: spdif_out_y {
+			mux {
+				groups = "spdif_out_y";
+				function = "spdif_out";
+			};
+		};
 	};
 };
 
-- 
2.9.3
