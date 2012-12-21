From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 21 Dec 2012 10:02:13 -0800
Subject: [PATCH] ARM: dts: fix duplicated build target and alphabetical sort
 out for exynos
Message-ID: <1356112933-6755-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit db5b0ae0 ("Merge tag 'dt' of git://git.kernel.org/.../arm-soc")
causes duplicated build target. This patch fixes it and sorts out the build
target alphabetically so that we can recognize something wrong easily.

Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/boot/dts/Makefile |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d077ef8..e44da40 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -42,11 +42,10 @@ dtb-$(CONFIG_ARCH_DOVE) += dove-cm-a510.dtb \
 dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
 	exynos4210-smdkv310.dtb \
 	exynos4210-trats.dtb \
-	exynos5250-smdk5250.dtb \
-	exynos5440-ssdk5440.dtb \
 	exynos4412-smdk4412.dtb \
 	exynos5250-smdk5250.dtb \
-	exynos5250-snow.dtb
+	exynos5250-snow.dtb \
+	exynos5440-ssdk5440.dtb
 dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
 	ecx-2000.dtb
 dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
-- 
1.7.10.4
