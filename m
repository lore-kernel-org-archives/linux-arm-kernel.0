From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Apr 2018 19:34:20 +0800
Subject: [PATCH 3/7] ARM: dts: sun8i: h2-plus: Sort dtb entries in Makefile
In-Reply-To: <20180424113424.13196-1-wens@csie.org>
References: <20180424113424.13196-1-wens@csie.org>
Message-ID: <20180424113424.13196-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dtb entry for the Banana Pi M2 Zero in the device tree makefile
somehow ended up in between two Orange Pi boards.

Move it so the list is properly sorted.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7e2424957809..5c979ed6c77b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -992,8 +992,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-a83t-bananapi-m3.dtb \
 	sun8i-a83t-cubietruck-plus.dtb \
 	sun8i-a83t-tbs-a711.dtb \
-	sun8i-h2-plus-orangepi-r1.dtb \
 	sun8i-h2-plus-bananapi-m2-zero.dtb \
+	sun8i-h2-plus-orangepi-r1.dtb \
 	sun8i-h2-plus-orangepi-zero.dtb \
 	sun8i-h3-bananapi-m2-plus.dtb \
 	sun8i-h3-beelink-x2.dtb \
-- 
2.17.0
