From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed,  6 Feb 2013 09:44:15 +0530
Subject: [PATCH] ARM: SPEAr13xx: Enable CONFIG_ARCH_HAS_CPUFREQ
Message-ID: <07186d8f30c387aa3f47be8c98d34678ca4b5ba9.1360123662.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SPEAr13xx supports cpufreq and has an upstreamed driver for it. This patch
enables cpufreq configs for SPEAr13xx.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/plat-spear/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/plat-spear/Kconfig b/arch/arm/plat-spear/Kconfig
index 87dbd81..739d016 100644
--- a/arch/arm/plat-spear/Kconfig
+++ b/arch/arm/plat-spear/Kconfig
@@ -10,6 +10,7 @@ choice
 
 config ARCH_SPEAR13XX
 	bool "ST SPEAr13xx with Device Tree"
+	select ARCH_HAVE_CPUFREQ
 	select ARM_GIC
 	select CPU_V7
 	select GPIO_SPEAR_SPICS
-- 
1.7.12.rc2.18.g61b472e
