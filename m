From: matthew@mattleach.net (Matthew Leach)
Date: Wed,  8 Jun 2016 19:31:06 +0100
Subject: [RFC PATCH 11/15] ARM: EXYNOS: Enable ARCH_SUPPORTS_BIG_ENDIAN
 explicitly
In-Reply-To: <20160608183110.13851-1-matthew@mattleach.net>
References: <20160608183110.13851-1-matthew@mattleach.net>
Message-ID: <20160608183110.13851-12-matthew@mattleach.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

Now the initial fixes have the big-endian code working on EXYNOS, make sure
we explicitly mark our arch as being big endian capable.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mach-exynos/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index e65aa7d..14906bf 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -13,6 +13,7 @@ menuconfig ARCH_EXYNOS
 	select ARCH_HAS_BANDGAP
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
 	select COMMON_CLK_SAMSUNG
-- 
2.8.3
