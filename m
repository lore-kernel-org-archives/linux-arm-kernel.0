From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 24 May 2017 10:28:22 +0200
Subject: [PATCH 2/5] ARM64: dts: meson-gxl: Add CEC pins nodes
In-Reply-To: <1495614505-4437-1-git-send-email-narmstrong@baylibre.com>
References: <1495614505-4437-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1495614505-4437-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the AO and EE domain CEC pins nodes for the Amlogic Meson GXL SoCs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 3efad5f..478d3b4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -190,6 +190,20 @@
 				function = "spdif_out_ao";
 			};
 		};
+
+		ao_cec_pins: ao_cec {
+			mux {
+				groups = "ao_cec";
+				function = "cec_ao";
+			};
+		};
+
+		ee_cec_pins: ee_cec {
+			mux {
+				groups = "ee_cec";
+				function = "cec_ao";
+			};
+		};
 	};
 };
 
-- 
1.9.1
