From: hdegoede@redhat.com (Hans de Goede)
Date: Wed,  9 Sep 2015 10:23:22 +0200
Subject: [PATCH 1/3] ARM: dts: sun4i: Fix itead-iteaduino-plus reference in
 Makefile
Message-ID: <1441787004-4660-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tell make to build a dtb, rather then the already existing dts.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 6d43044..e12aeae 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -554,7 +554,7 @@ dtb-$(CONFIG_MACH_SUN4I) += \
 	sun4i-a10-hackberry.dtb \
 	sun4i-a10-hyundai-a7hd.dtb \
 	sun4i-a10-inet97fv2.dtb \
-	sun4i-a10-itead-iteaduino-plus.dts \
+	sun4i-a10-itead-iteaduino-plus.dtb \
 	sun4i-a10-jesurun-q5.dtb \
 	sun4i-a10-marsboard.dtb \
 	sun4i-a10-mini-xplus.dtb \
-- 
2.4.3
