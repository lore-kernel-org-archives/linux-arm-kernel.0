From: mikko.perttunen@kapsi.fi (Mikko Perttunen)
Date: Sun,  1 Mar 2015 14:44:41 +0200
Subject: [PATCH v8 18/18] ARM: tegra: enable Tegra124 cpufreq driver by default
In-Reply-To: <1425213881-5262-1-git-send-email-mikko.perttunen@kapsi.fi>
References: <1425213881-5262-1-git-send-email-mikko.perttunen@kapsi.fi>
Message-ID: <1425213881-5262-19-git-send-email-mikko.perttunen@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>

The Tegra124 cpufreq driver depends on CONFIG_CPUFREQ_DT, so
enable it to get the Tegra driver to build by default.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index d199eb2..5eb4bad 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -42,6 +42,7 @@ CONFIG_KEXEC=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT_DETAILS=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
+CONFIG_CPUFREQ_DT=y
 CONFIG_CPU_IDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
--
2.3.0
