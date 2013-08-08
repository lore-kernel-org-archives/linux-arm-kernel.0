From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu,  8 Aug 2013 18:32:08 -0300
Subject: [PATCH] ARM: omap2: Use a consistent AM33XX SoC option description
Message-ID: <1375997528-396-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the option description to match the other TI SoCs.
This is just a cosmetic change.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-omap2/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 76170dd..56021c6 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -64,7 +64,7 @@ config SOC_OMAP5
 	select ARM_ERRATA_798181 if SMP
 
 config SOC_AM33XX
-	bool "AM33XX support"
+	bool "TI AM33XX"
 	depends on ARCH_MULTI_V7
 	select ARCH_OMAP2PLUS
 	select ARM_CPU_SUSPEND if PM
-- 
1.8.1.5
