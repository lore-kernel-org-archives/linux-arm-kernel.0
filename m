From: weber@corscience.de (Thomas Weber)
Date: Thu, 18 Mar 2010 14:17:43 +0100
Subject: [PATCH] OMAP: Devkit8000: Add missing package selection
Message-ID: <1268918263-22127-1-git-send-email-weber@corscience.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing selection of CUS package.
Replace whitespace with tab.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/Kconfig |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index a8a3d1e..e776075 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -59,8 +59,9 @@ config MACH_OMAP3_BEAGLE
 	select OMAP_PACKAGE_CBB
 
 config MACH_DEVKIT8000
-        bool "DEVKIT8000 board"
-        depends on ARCH_OMAP3
+	bool "DEVKIT8000 board"
+	depends on ARCH_OMAP3
+	select OMAP_PACKAGE_CUS
 
 config MACH_OMAP_LDP
 	bool "OMAP3 LDP board"
-- 
1.6.4.4
