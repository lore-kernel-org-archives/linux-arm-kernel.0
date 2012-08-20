From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 20 Aug 2012 09:41:23 -0600
Subject: [PATCH] ARM: tegra: remove duplicate select USE_OF
Message-ID: <1345477283-26000-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

ARCH_TEGRA (arch/arm/Kconfig) now selects USE_OF, so there's not need
for ARCH_TEGRA_3x_SOC to do so too.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index d3e73ec..b3226f8 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -34,7 +34,6 @@ config ARCH_TEGRA_3x_SOC
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select USB_ULPI if USB
 	select USB_ULPI_VIEWPORT if USB_SUPPORT
-	select USE_OF
 	select ARM_ERRATA_743622
 	select ARM_ERRATA_751472
 	select ARM_ERRATA_754322
-- 
1.7.0.4
