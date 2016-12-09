From: woogyom.kim@gmail.com (Milo Kim)
Date: Fri,  9 Dec 2016 10:47:58 +0900
Subject: [PATCH] ARM: dts: sun8i: Support DTB build for NanoPi M1
Message-ID: <20161209014758.27368-1-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 10efbf5f1633 introduced NanoPi M1 board but it's missing in
Allwinner H3 DTB build.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 arch/arm/boot/dts/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index cccdbcb..4cbdf6f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -845,6 +845,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-a83t-allwinner-h8homlet-v2.dtb \
 	sun8i-a83t-cubietruck-plus.dtb \
 	sun8i-h3-bananapi-m2-plus.dtb \
+	sun8i-h3-nanopi-m1.dtb \
 	sun8i-h3-nanopi-neo.dtb \
 	sun8i-h3-orangepi-2.dtb \
 	sun8i-h3-orangepi-lite.dtb \
-- 
2.9.3
