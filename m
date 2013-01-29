From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 29 Jan 2013 18:26:17 +0530
Subject: [PATCH 1/7] ARM: tegra114: select PINCTRL for Tegra114 SoC
In-Reply-To: <1359464183-6255-1-git-send-email-ldewangan@nvidia.com>
References: <1359464183-6255-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1359464183-6255-2-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select PINCTRL and PINCTRL_TEGRA114 for enabling Tegra114 pincontrol
driver for Tegra114 SoC.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index eada60f..bde8197 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -51,6 +51,8 @@ config ARCH_TEGRA_114_SOC
 	select CPU_V7
 	select ARM_L1_CACHE_SHIFT_6
 	select ARM_ARCH_TIMER
+	select PINCTRL
+	select PINCTRL_TEGRA114
 	help
 	  Support for NVIDIA Tegra T114 processor family, based on the
 	  ARM CortexA15MP CPU
-- 
1.7.1.1
