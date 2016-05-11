From: oliver@schinagl.nl (Olliver Schinagl)
Date: Wed, 11 May 2016 10:27:07 +0200
Subject: [PATCH 1/1] devicetree: sunxi: Add OLinuXino Lime2 eMMC to the
 Makefile
Message-ID: <1462955227-4454-1-git-send-email-oliver@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: dts: sunxi: Add a olinuxino-lime2-emmc added the new emmc equipped
lime2 but forgot its Makefile. This patch adds an entry to the Makefile.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
Hi list,

would it be possible to squash or atleast add this patch with/to my previous
patch, ARM: dts: sunxi: Add a olinuxino-lime2-emmc? I mistakenly forgot to
add the changes to the Makefile in the patch.

Sorry, and thank you!

Olliver

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
