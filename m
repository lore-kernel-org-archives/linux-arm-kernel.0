From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 22 Feb 2016 15:33:14 +0530
Subject: [PATCH 1/3] ARM: EXYNOS: correct header comment in Kconfig file
In-Reply-To: <1456135396-17767-1-git-send-email-pankaj.dubey@samsung.com>
References: <1456135396-17767-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1456135396-17767-2-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch corrects header comment of Kconfig file by changing EXYNOS4 to
EXYNOS.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index eb26986..71ef48f 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -5,7 +5,7 @@
 #
 # Licensed under GPLv2
 
-# Configuration options for the EXYNOS4
+# Configuration options for the EXYNOS
 
 menuconfig ARCH_EXYNOS
 	bool "Samsung EXYNOS"
-- 
2.4.5
