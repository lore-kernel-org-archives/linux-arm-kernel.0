From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 23 Mar 2017 17:51:01 +0100
Subject: [PATCH 8/8] ARM64: dts: meson-gxl: add spdif output pins
In-Reply-To: <20170323165101.29262-1-jbrunet@baylibre.com>
References: <20170323165101.29262-1-jbrunet@baylibre.com>
Message-ID: <20170323165101.29262-9-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 88ad3490c124..8f57e74b719c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -138,6 +138,20 @@
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
+		spdif_out_ao_9_pins: spdif_out_ao_9 {
+			mux {
+				groups = "spdif_out_ao_9";
+				function = "spdif_out_ao";
+			};
+		};
 	};
 };
 
@@ -359,6 +373,13 @@
 				function = "i2s_out";
 			};
 		};
+
+		spdif_out_h_pins: spdif_out_ao_h {
+			mux {
+				groups = "spdif_out_h";
+				function = "spdif_out";
+			};
+		};
 	};
 
 	eth-phy-mux {
-- 
2.9.3
