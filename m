From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 14 Dec 2012 15:55:39 -0600
Subject: [PATCH] ARM: dts: Add build target for omap4-panda-a4
Message-ID: <1355522139-8241-1-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 0d9250c (ARM: dts: omap4-panda: Add pinmux configuration for
HDMI) added a new device-tree source file for Rev A4 of the OMAP4430
Panda board but it did not add this version to the makefile. Hence,
add this file to the makefile.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/boot/dts/Makefile |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 2af359c..f8b4ff4 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -105,6 +105,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap3-evm.dtb \
 	omap3-tobi.dtb \
 	omap4-panda.dtb \
+	omap4-panda-a4.dtb \
 	omap4-panda-es.dtb \
 	omap4-var-som.dtb \
 	omap4-sdp.dtb \
-- 
1.7.10.4
