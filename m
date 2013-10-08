From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  9 Oct 2013 00:34:24 +0200
Subject: [PATCH 08/23] ARM: highbank: enable big-endian
In-Reply-To: <1381271679-27804-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1381271679-27804-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1381271679-27804-9-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apart from a xgmac driver issue, the highbank seems to work correctly in
big-endian mode. Allow the selection of big-endian in the system.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Acked-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-highbank/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
index 8e8437d..3c3bff7 100644
--- a/arch/arm/mach-highbank/Kconfig
+++ b/arch/arm/mach-highbank/Kconfig
@@ -4,6 +4,7 @@ config ARCH_HIGHBANK
 	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_HAS_OPP
+	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_AMBA
 	select ARM_ERRATA_764369
-- 
1.8.4.rc3
