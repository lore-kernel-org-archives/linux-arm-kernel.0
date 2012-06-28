From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Thu, 28 Jun 2012 16:07:23 +0530
Subject: [PATCH 3/6] ARM: tegra: Rename tegra20 clock file
In-Reply-To: <1340879846-12900-1-git-send-email-pgaikwad@nvidia.com>
References: <1340879846-12900-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <1340879846-12900-4-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the name consistent with other files.
s/tegra2/tegra20

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
 arch/arm/mach-tegra/Makefile                       |    2 +-
 .../{tegra2_clocks.c => tegra20_clocks.c}          |    0
 2 files changed, 1 insertions(+), 1 deletions(-)
 rename arch/arm/mach-tegra/{tegra2_clocks.c => tegra20_clocks.c} (100%)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 141bf4b..452c105 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -11,7 +11,7 @@ obj-y					+= flowctrl.o
 obj-y					+= powergate.o
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
 obj-$(CONFIG_CPU_IDLE)			+= sleep.o
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra2_clocks.o
+obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra20_clocks.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra20_clocks_data.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra2_emc.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= tegra30_clocks.o
diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra20_clocks.c
similarity index 100%
rename from arch/arm/mach-tegra/tegra2_clocks.c
rename to arch/arm/mach-tegra/tegra20_clocks.c
-- 
1.7.4.1
