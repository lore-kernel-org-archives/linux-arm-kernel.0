From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:25:35 +0900
Subject: [PATCH 4/4] ARM: shmobile: Enable CPUFREQ configuration
In-Reply-To: <cover.1403487196.git.horms+renesas@verge.net.au>
References: <cover.1403487196.git.horms+renesas@verge.net.au>
Message-ID: <468c570ed078f0326745bfe85868adb925659502.1403487196.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

This changes of configuration is multiplatform build only for r8a7790/r8a7791.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 94d7736..c4b72aa 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -147,3 +147,16 @@ CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_ARM_UNWIND is not set
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_GOV_COMMON=y
+CONFIG_CPU_FREQ_STAT=y
+CONFIG_CPU_FREQ_STAT_DETAILS=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
+CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
+CONFIG_CPU_THERMAL=y
+CONFIG_GENERIC_CPUFREQ_CPU0=y
+CONFIG_REGULATOR_DA9210=y
-- 
2.0.0.rc2
