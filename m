From: pebolle@tiscali.nl (Paul Bolle)
Date: Sun, 06 Apr 2014 12:19:13 +0200
Subject: [PATCH] ARM: tegra: remove TEGRA_EMC_SCALING_ENABLE
Message-ID: <1396779553.30640.16.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a7cbe92cef27 ("ARM: tegra: remove tegra EMC scaling driver")
removed the only user of TEGRA_EMC_SCALING_ENABLE. Remove its Kconfig
entry too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
 arch/arm/mach-tegra/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 92d660f9610f..55b305d51669 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -70,7 +70,4 @@ config TEGRA_AHB
 	  which controls AHB bus master arbitration and some
 	  performance parameters(priority, prefech size).
 
-config TEGRA_EMC_SCALING_ENABLE
-	bool "Enable scaling the memory frequency"
-
 endmenu
-- 
1.9.0
