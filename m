From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 20 Jan 2017 23:21:02 +0100
Subject: [PATCH 02/18] ARM64: dts: amlogic: Sort Makefile
In-Reply-To: <20170120222118.21476-1-afaerber@suse.de>
References: <20170120222118.21476-1-afaerber@suse.de>
Message-ID: <20170120222118.21476-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/amlogic/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 3f94bce33b7f..efcd1763a82d 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -7,13 +7,13 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-meta.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-telos.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-wetek-hub.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-wetek-play2.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb
-dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxm-nexbox-a1.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q200.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q201.dtb
-dtb-$(CONFIG_ARCH_MESON) += meson-gxm-nexbox-a1.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-- 
2.10.2
