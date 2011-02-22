From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 22 Feb 2011 20:35:24 +0000
Subject: [PATCH] ARM: tegra: Hide EMC scaling config behind ARCH_TEGRA
In-Reply-To: <>
References: <>
Message-ID: <1298406924-2074-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The option isn't terribly useful on other ARM platforms.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-tegra/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index cac8a79..bdf52f0 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -64,7 +64,7 @@ config TEGRA_SYSTEM_DMA
 	  Adds system DMA functionality for NVIDIA Tegra SoCs, used by
 	  several Tegra device drivers
 
-endif
-
 config TEGRA_EMC_SCALING_ENABLE
 	bool "Enable scaling the memory frequency"
+
+endif
-- 
1.7.2.3
