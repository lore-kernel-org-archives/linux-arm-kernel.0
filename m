From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 23 Jan 2015 23:37:05 +0300
Subject: [PATCH] ARM: shmobile: henninger: rename board to Porter
Message-ID: <2481726.lh33apx2TG@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Renesas has made some changes to the Henninger low cost board hardware and at
the same time decided to  rename the board  to Porter.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'renesas-devel-20150123-v3.19-rc5' tag of Simon Horman's
'renesas.git' repo.

 arch/arm/boot/dts/Makefile                                     |  2 +-
 .../arm/boot/dts/{r8a7791-henninger.dts => r8a7791-porter.dts} | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)
 rename arch/arm/boot/dts/{r8a7791-henninger.dts => r8a7791-porter.dts} (96%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 59e79e9..3cc8ba5 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -419,8 +419,8 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += eme
 	r8a7740-armadillo800eva.dtb \
 	r8a7779-marzen.dtb \
 	r8a7790-lager.dtb \
-	r8a7791-henninger.dtb \
 	r8a7791-koelsch.dtb \
+	r8a7791-porter.dtb \
 	r8a7794-alt.dtb \
 	sh73a0-kzm9g.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
diff --git a/arch/arm/boot/dts/r8a7791-henninger.dts b/arch/arm/boot/dts/r8a7791-porter.dts
similarity index 96%
rename from arch/arm/boot/dts/r8a7791-henninger.dts
rename to arch/arm/boot/dts/r8a7791-porter.dts
index d2ebf11..4a616dc 100644
--- a/arch/arm/boot/dts/r8a7791-henninger.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -1,8 +1,8 @@
 /*
- * Device Tree Source for the Henninger board
+ * Device Tree Source for the Porter board
  *
- * Copyright (C) 2014 Renesas Solutions Corp.
- * Copyright (C) 2014 Cogent Embedded, Inc.
+ * Copyright (C) 2014-2015 Renesas Solutions Corp.
+ * Copyright (C) 2014-2015 Cogent Embedded, Inc.
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2.  This program is licensed "as is" without any warranty of any
@@ -14,8 +14,8 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
-	model = "Henninger";
-	compatible = "renesas,henninger", "renesas,r8a7791";
+	model = "Porter";
+	compatible = "renesas,porter", "renesas,r8a7791";
 
 	aliases {
 		serial0 = &scif0;
