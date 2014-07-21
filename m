From: ttynkkynen@nvidia.com (Tuomas Tynkkynen)
Date: Mon, 21 Jul 2014 18:39:02 +0300
Subject: [PATCH v2 16/16] ARM: tegra: Update defconfig for tegra124-cpufreq
In-Reply-To: <1405957142-19416-1-git-send-email-ttynkkynen@nvidia.com>
References: <1405957142-19416-1-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <1405957142-19416-17-git-send-email-ttynkkynen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tegra124-cpufreq driver depends on cpufreq-cpu0, so enable
GENERIC_CPUFREQ_CPU0 to get the Tegra driver to build by default.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 285c433..afaa97c 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -43,6 +43,7 @@ CONFIG_KEXEC=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT_DETAILS=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
+CONFIG_GENERIC_CPUFREQ_CPU0=y
 CONFIG_CPU_IDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
-- 
1.8.1.5
