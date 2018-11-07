From: marc.w.gonzalez@free.fr (Marc Gonzalez)
Date: Wed, 7 Nov 2018 23:39:42 +0100
Subject: [PATCH v2 2/9] arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
In-Reply-To: <898e79a6-092c-d013-d2bb-f6260e761379@free.fr>
References: <898e79a6-092c-d013-d2bb-f6260e761379@free.fr>
Message-ID: <03f41ca8-68c6-f075-cb1e-c7f630a3b128@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a7314405d83c ("drop ARM_BIG_LITTLE_CPUFREQ support for ARM64")
dropped ARM_BIG_LITTLE_CPUFREQ support for ARM64.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f786c95504d3..8d6878c1e794 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -107,7 +107,6 @@ CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_ACPI_CPPC_CPUFREQ=m
 CONFIG_ARM_ARMADA_37XX_CPUFREQ=y
-CONFIG_ARM_BIG_LITTLE_CPUFREQ=y
 CONFIG_ARM_SCPI_CPUFREQ=y
 CONFIG_ARM_TEGRA186_CPUFREQ=y
 CONFIG_ARM_SCPI_PROTOCOL=y
-- 
2.17.1
