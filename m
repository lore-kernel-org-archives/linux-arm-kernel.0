From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 24 May 2017 10:28:21 +0200
Subject: [PATCH 1/5] ARM64: dts: meson-gxbb: Add CEC pins nodes
In-Reply-To: <1495614505-4437-1-git-send-email-narmstrong@baylibre.com>
References: <1495614505-4437-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1495614505-4437-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the AO and EE domain CEC pins nodes for the Amlogic Meson GXBB SoCs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 6f8b301..f0cfb02 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -242,6 +242,20 @@
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
