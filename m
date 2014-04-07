From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon,  7 Apr 2014 10:52:23 -0600
Subject: [PATCH] ARM: tegra: remove TEGRA_EMC_SCALING_ENABLE
Message-ID: <1396889543-11896-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Paul Bolle <pebolle@tiscali.nl>

Commit a7cbe92cef27 ("ARM: tegra: remove tegra EMC scaling driver")
removed the only user of TEGRA_EMC_SCALING_ENABLE. Remove its Kconfig
entry too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
arm-soc, this is another fix patch for 3.15.

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
1.8.1.5
