From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 11 Jul 2012 12:46:17 +0800
Subject: [PATCH] ARM: mxs: rename dts files with soc name being the prefix
Message-ID: <1341981977-18207-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename mxs dts files with soc name being the prefix, so that the board
dts file can be located easily by soc name, and we also gain the
consistency of naming.

Suggested-by: Marek Vasut <marex@denx.de>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../boot/dts/{cfa10036.dts => imx23-cfa10036.dts}  |    0
 .../{stmp378x_devb.dts => imx23-stmp378x_devb.dts} |    0
 .../dts/{apx4devkit.dts => imx28-apx4devkit.dts}   |    0
 arch/arm/boot/dts/{m28evk.dts => imx28-m28evk.dts} |    0
 arch/arm/boot/dts/{tx28.dts => imx28-tx28.dts}     |    0
 arch/arm/mach-mxs/Makefile.boot                    |   10 +++++-----
 6 files changed, 5 insertions(+), 5 deletions(-)
 rename arch/arm/boot/dts/{cfa10036.dts => imx23-cfa10036.dts} (100%)
 rename arch/arm/boot/dts/{stmp378x_devb.dts => imx23-stmp378x_devb.dts} (100%)
 rename arch/arm/boot/dts/{apx4devkit.dts => imx28-apx4devkit.dts} (100%)
 rename arch/arm/boot/dts/{m28evk.dts => imx28-m28evk.dts} (100%)
 rename arch/arm/boot/dts/{tx28.dts => imx28-tx28.dts} (100%)

diff --git a/arch/arm/boot/dts/cfa10036.dts b/arch/arm/boot/dts/imx23-cfa10036.dts
similarity index 100%
rename from arch/arm/boot/dts/cfa10036.dts
rename to arch/arm/boot/dts/imx23-cfa10036.dts
diff --git a/arch/arm/boot/dts/stmp378x_devb.dts b/arch/arm/boot/dts/imx23-stmp378x_devb.dts
similarity index 100%
rename from arch/arm/boot/dts/stmp378x_devb.dts
rename to arch/arm/boot/dts/imx23-stmp378x_devb.dts
diff --git a/arch/arm/boot/dts/apx4devkit.dts b/arch/arm/boot/dts/imx28-apx4devkit.dts
similarity index 100%
rename from arch/arm/boot/dts/apx4devkit.dts
rename to arch/arm/boot/dts/imx28-apx4devkit.dts
diff --git a/arch/arm/boot/dts/m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
similarity index 100%
rename from arch/arm/boot/dts/m28evk.dts
rename to arch/arm/boot/dts/imx28-m28evk.dts
diff --git a/arch/arm/boot/dts/tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
similarity index 100%
rename from arch/arm/boot/dts/tx28.dts
rename to arch/arm/boot/dts/imx28-tx28.dts
diff --git a/arch/arm/mach-mxs/Makefile.boot b/arch/arm/mach-mxs/Makefile.boot
index 58733cc..33181c0 100644
--- a/arch/arm/mach-mxs/Makefile.boot
+++ b/arch/arm/mach-mxs/Makefile.boot
@@ -1,10 +1,10 @@
 zreladdr-y += 0x40008000
 
-dtb-y += apx4devkit.dtb \
-	 cfa10036.dtb \
+dtb-y += imx23-cfa10036.dtb \
 	 imx23-evk.dtb \
 	 imx23-olinuxino.dtb \
+	 imx23-stmp378x_devb.dtb \
+	 imx28-apx4devkit.dtb \
 	 imx28-evk.dtb \
-	 m28evk.dtb \
-	 stmp378x_devb.dtb \
-	 tx28.dtb \
+	 imx28-m28evk.dtb \
+	 imx28-tx28.dtb \
-- 
1.7.5.4
