From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Thu, 16 Nov 2017 13:46:51 +0200
Subject: [PATCH 1/2] arm64: defconfig: Enable CONFIG_ARM_TEGRA186_CPUFREQ
Message-ID: <20171116114652.25321-1-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Tegra186 CPU frequency scaling support by default.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6356c6da34ea..42711031a72d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -101,6 +101,7 @@ CONFIG_CPU_FREQ=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_ARM_BIG_LITTLE_CPUFREQ=y
 CONFIG_ARM_SCPI_CPUFREQ=y
+CONFIG_ARM_TEGRA186_CPUFREQ=y
 CONFIG_ACPI_CPPC_CPUFREQ=m
 CONFIG_NET=y
 CONFIG_PACKET=y
-- 
2.14.2
