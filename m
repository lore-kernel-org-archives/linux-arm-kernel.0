From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 11 Oct 2017 17:39:39 +0200
Subject: [PATCH 1/2] ARM64: dts: meson-gx: remove unnecessary clocks properties
In-Reply-To: <1507736380-21019-1-git-send-email-narmstrong@baylibre.com>
References: <1507736380-21019-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1507736380-21019-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the switch to documented uart bindings, the clocks are
redefined in the SoC family dtsi file.

This patch removes these unneeded properties.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index f175db8..2be981a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -228,7 +228,6 @@
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
 				reg = <0x0 0x84c0 0x0 0x14>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&xtal>;
 				status = "disabled";
 			};
 
@@ -236,7 +235,6 @@
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
 				reg = <0x0 0x84dc 0x0 0x14>;
 				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&xtal>;
 				status = "disabled";
 			};
 
@@ -282,7 +280,6 @@
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
 				reg = <0x0 0x8700 0x0 0x14>;
 				interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&xtal>;
 				status = "disabled";
 			};
 
-- 
2.7.4
