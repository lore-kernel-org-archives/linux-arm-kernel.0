From: stefan@olimex.com (Stefan Mavrodiev)
Date: Tue, 22 Aug 2017 14:43:13 +0300
Subject: [PATCH 3/3] ARM: dts: sun7i: Rename sun7i-a20-olinuxino-lime2-emmc
In-Reply-To: <20170822114313.9038-1-stefan@olimex.com>
References: <20170822114313.9038-1-stefan@olimex.com>
Message-ID: <20170822114313.9038-4-stefan@olimex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename dts file for A20-OLinuXino-LIME2-eMMC to match Olimex Ltd.
naming convention.

<board-name>-exGB - option with <x>GB eMMC chip
<board-name>-nxGB - option with <x>GB NAND chip
<board-name>-sxMB - option with <x>MB SPI FLASH chip

For example:
	A20-OLinuXino-LIME2-e4GB - 4GB eMMC
	A20-OLinuXIno-LIME2-n4GB - 4GB NAND
	A20-OLinuXIno-LIME2-n8GB - 8GB NAND

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
 arch/arm/boot/dts/Makefile                                            | 2 +-
 ...20-olinuxino-lime2-emmc.dts => sun7i-a20-olinuxino-lime2-exgb.dts} | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename arch/arm/boot/dts/{sun7i-a20-olinuxino-lime2-emmc.dts => sun7i-a20-olinuxino-lime2-exgb.dts} (96%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 90cbfc57948e..d37e93175fbf 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -878,7 +878,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-olimex-som-evb.dtb \
 	sun7i-a20-olinuxino-lime.dtb \
 	sun7i-a20-olinuxino-lime2.dtb \
-	sun7i-a20-olinuxino-lime2-emmc.dtb \
+	sun7i-a20-olinuxino-lime2-exgb.dtb \
 	sun7i-a20-olinuxino-micro.dtb \
 	sun7i-a20-olinuxino-micro-exgb.dtb \
 	sun7i-a20-orangepi.dtb \
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-exgb.dts
similarity index 96%
rename from arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
rename to arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-exgb.dts
index 81f376f2a44d..38d95eaaa224 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-exgb.dts
@@ -44,8 +44,8 @@
 #include "sun7i-a20-olinuxino-lime2.dts"
 
 / {
-	model = "Olimex A20-OLinuXino-LIME2-eMMC";
-	compatible = "olimex,a20-olinuxino-lime2-emmc", "allwinner,sun7i-a20";
+	model = "Olimex A20-OLinuXino-LIME2-exGB";
+	compatible = "olimex,a20-olinuxino-lime2-exgb", "allwinner,sun7i-a20";
 
 	mmc2_pwrseq: pwrseq {
 		pinctrl-0 = <&mmc2_pins_nrst>;
-- 
2.11.0
