From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 5 Dec 2013 16:27:49 +0530
Subject: [PATCH 3/4] ARM: tegra: select PINCTRL_TEGRA124 for Tegra124 SoC
In-Reply-To: <1386241070-4350-1-git-send-email-ldewangan@nvidia.com>
References: <1386241070-4350-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1386241070-4350-4-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pincontrol driver for Tegra124 is build through config
PINCTRL_TEGRA124. Select this config option whenever Tegra124
SoC is enabled.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 09e740f..807e7bc 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -63,6 +63,7 @@ config ARCH_TEGRA_124_SOC
 	bool "Enable support for Tegra124 family"
 	select ARM_L1_CACHE_SHIFT_6
 	select HAVE_ARM_ARCH_TIMER
+	select PINCTRL_TEGRA124
 	help
 	  Support for NVIDIA Tegra T124 processor family, based on the
 	  ARM CortexA15MP CPU
-- 
1.7.1.1
