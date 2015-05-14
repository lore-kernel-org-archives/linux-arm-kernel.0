From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 14 May 2015 21:16:35 +0900
Subject: [PATCH] MAINTAINERS: ARM64: EXYNOS: Extend entry for ARM64 DTS
Message-ID: <1431605795-902-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the Exynos entry to ARM64 device tree sources.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a3cb77c0ae23..619a95558673 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1386,6 +1386,7 @@ L:	linux-samsung-soc at vger.kernel.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/boot/dts/s3c*
 F:	arch/arm/boot/dts/exynos*
+F:	arch/arm64/boot/dts/exynos/
 F:	arch/arm/plat-samsung/
 F:	arch/arm/mach-s3c24*/
 F:	arch/arm/mach-s3c64xx/
-- 
2.1.4
