From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 20 Jan 2017 09:38:43 -0800
Subject: [PATCH] ARM64: dts: meson-gxl: rename Nexbox A95x for consistency
Message-ID: <20170120173843.6522-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the GXL family has S905X and S905D SoCs, we're keeping the SoC
name in the DTS filename for clarity.  Rename this file accordingly to
be consistent with the rest of the GXL DTS files.

Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/Makefile                                    | 2 +-
 .../{meson-gxl-nexbox-a95x.dts => meson-gxl-s905x-nexbox-a95x.dts}      | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm64/boot/dts/amlogic/{meson-gxl-nexbox-a95x.dts => meson-gxl-s905x-nexbox-a95x.dts} (100%)

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 293e985e3dfa..3f94bce33b7f 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -10,7 +10,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-wetek-play2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb
-dtb-$(CONFIG_ARCH_MESON) += meson-gxl-nexbox-a95x.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q200.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q201.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-nexbox-a1.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
similarity index 100%
rename from arch/arm64/boot/dts/amlogic/meson-gxl-nexbox-a95x.dts
rename to arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
-- 
2.9.3
