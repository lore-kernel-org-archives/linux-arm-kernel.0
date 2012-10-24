From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 24 Oct 2012 17:30:36 +0200
Subject: [PATCH] ARM: dts: OMAP: Rename pandaES and var_som for consistency
Message-ID: <5088099C.8020308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename the files to have consistent names across OMAP boards.

Update the Makefile to use the new names.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Uri Yosef <uri.y@variscite.com>
---
 arch/arm/boot/dts/Makefile                         |    4 ++--
 .../dts/{omap4-pandaES.dts => omap4-panda-es.dts}  |    0
 .../dts/{omap4-var_som.dts => omap4-var-som.dts}   |    0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/boot/dts/{omap4-pandaES.dts => omap4-panda-es.dts} (100%)
 rename arch/arm/boot/dts/{omap4-var_som.dts => omap4-var-som.dts} (100%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e69c921..634bd42 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -68,8 +68,8 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap3-evm.dtb \
 	omap3-tobi.dtb \
 	omap4-panda.dtb \
-	omap4-pandaES.dtb \
-	omap4-var_som.dtb \
+	omap4-panda-es.dtb \
+	omap4-var-som.dtb \
 	omap4-sdp.dtb \
 	omap5-evm.dtb \
 	am335x-evm.dtb \
diff --git a/arch/arm/boot/dts/omap4-pandaES.dts b/arch/arm/boot/dts/omap4-panda-es.dts
similarity index 100%
rename from arch/arm/boot/dts/omap4-pandaES.dts
rename to arch/arm/boot/dts/omap4-panda-es.dts
diff --git a/arch/arm/boot/dts/omap4-var_som.dts b/arch/arm/boot/dts/omap4-var-som.dts
similarity index 100%
rename from arch/arm/boot/dts/omap4-var_som.dts
rename to arch/arm/boot/dts/omap4-var-som.dts
-- 
1.7.0.4
