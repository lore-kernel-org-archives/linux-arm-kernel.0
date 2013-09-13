From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 13 Sep 2013 12:28:31 -0600
Subject: [PATCH] ARM: tegra: enable CPU_FREQ_STAT_DETAILS
Message-ID: <1379096911-28353-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This enables various sysfs files that are useful when testing cpufreq.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index ea042e8..bb28099 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -41,6 +41,7 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_KEXEC=y
 CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_STAT_DETAILS=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_IDLE=y
 CONFIG_VFP=y
-- 
1.8.1.5
