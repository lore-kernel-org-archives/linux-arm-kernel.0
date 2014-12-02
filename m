From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  2 Dec 2014 18:11:53 +0100
Subject: [PATCH] ARM: configs: enable CPUFREQ_DT in multi_v7_defconfig
Message-ID: <1417540313-6359-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit bbcf071969b20 ("cpufreq: cpu0: rename driver and internals
to 'cpufreq_dt'"), the generic cpufreq driver has been renamed, and
its Kconfig option as well. Therefore, the multi_v7_defconfig should
be updated accordingly, and enable CONFIG_CPUFREQ_DT instead of
CONFIG_GENERIC_CPUFREQ_CPU0.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Commit based on arm-soc/next/defconfig.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 82ed3fe..0a94bbc 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -470,4 +470,4 @@ CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_LOCKUP_DETECTOR=y
 CONFIG_CRYPTO_DEV_TEGRA_AES=y
-CONFIG_GENERIC_CPUFREQ_CPU0=y
+CONFIG_CPUFREQ_DT=y
-- 
2.1.0
