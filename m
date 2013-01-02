From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  2 Jan 2013 14:12:21 -0700
Subject: [PATCH] ARM: tegra: add kexec support to defconfig
Message-ID: <1357161141-26430-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/configs/tegra_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 742dc41..e621603 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -34,6 +34,7 @@ CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_KEXEC=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_IDLE=y
-- 
1.7.10.4
