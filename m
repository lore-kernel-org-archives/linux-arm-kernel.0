From: oliver@schinagl.nl (Olliver Schinagl)
Date: Thu, 12 May 2016 12:10:51 +0200
Subject: [PATCHv2] devicetree: sunxi: Add OLinuXino Lime2 eMMC to the Makefile
Message-ID: <1463047851-2039-1-git-send-email-oliver@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 27dd9af6bc (ARM: dts: sunxi: Add a olinuxino-lime2-emmc added the new
emmc equipped) lime2 but forgot its Makefile.

This patch adds an entry to the Makefile.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
Changes since v0:
  Added proper commit reference.

 arch/arm/boot/dts/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 95c1923..07f4cf8 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -695,6 +695,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-olimex-som-evb.dtb \
 	sun7i-a20-olinuxino-lime.dtb \
 	sun7i-a20-olinuxino-lime2.dtb \
+	sun7i-a20-olinuxino-lime2-emmc.dtb \
 	sun7i-a20-olinuxino-micro.dtb \
 	sun7i-a20-orangepi.dtb \
 	sun7i-a20-orangepi-mini.dtb \
-- 
2.8.1
