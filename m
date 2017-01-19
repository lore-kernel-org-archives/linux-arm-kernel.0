From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 19 Jan 2017 09:21:57 +0100
Subject: [PATCH] ARM64: dts: meson-gxm: Rename q200 and q201 DT files for
 consistency
Message-ID: <1484814117-7593-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to keep consistency naming with the Nexbox A1 DTS file, remove the
S912 SoC name in the GXM DT files.

Suggested-by: Andreas F?rber <afaerber@suse.de>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/Makefile                                  | 4 ++--
 .../boot/dts/amlogic/{meson-gxm-s912-q200.dts => meson-gxm-q200.dts}  | 0
 .../boot/dts/amlogic/{meson-gxm-s912-q201.dts => meson-gxm-q201.dts}  | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm64/boot/dts/amlogic/{meson-gxm-s912-q200.dts => meson-gxm-q200.dts} (100%)
 rename arch/arm64/boot/dts/amlogic/{meson-gxm-s912-q201.dts => meson-gxm-q201.dts} (100%)

Kevin, is this patch format correct for you to apply ?

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 0d7bfbf..1aca8e5 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -9,8 +9,8 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-nexbox-a95x.dtb
-dtb-$(CONFIG_ARCH_MESON) += meson-gxm-s912-q200.dtb
-dtb-$(CONFIG_ARCH_MESON) += meson-gxm-s912-q201.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q200.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q201.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-nexbox-a1.dtb
 
 always		:= $(dtb-y)
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts
similarity index 100%
rename from arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts
rename to arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-s912-q201.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-q201.dts
similarity index 100%
rename from arch/arm64/boot/dts/amlogic/meson-gxm-s912-q201.dts
rename to arch/arm64/boot/dts/amlogic/meson-gxm-q201.dts
-- 
1.9.1
