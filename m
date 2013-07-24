From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 24 Jul 2013 13:36:47 +0900
Subject: [PATCH] ARM: dts: re-ordering exynos dtbs in Makefile
Message-ID: <0e0c01ce8827$6850a220$38f1e660$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Re-ordering in alphabetical.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/boot/dts/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 641b3c9..ad340e4 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -53,13 +53,13 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
 	exynos4210-trats.dtb \
 	exynos4210-universal_c210.dtb \
 	exynos4412-odroidx.dtb \
-	exynos4412-smdk4412.dtb \
 	exynos4412-origen.dtb \
+	exynos4412-smdk4412.dtb \
 	exynos5250-arndale.dtb \
-	exynos5440-sd5v1.dtb \
 	exynos5250-smdk5250.dtb \
 	exynos5250-snow.dtb \
 	exynos5420-smdk5420.dtb \
+	exynos5440-sd5v1.dtb \
 	exynos5440-ssdk5440.dtb
 dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
 	ecx-2000.dtb
-- 
1.7.10.4
