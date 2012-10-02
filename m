From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue,  2 Oct 2012 13:10:48 -0600
Subject: [PATCH 2/2] ARM: tegra: remove "Tegra board type" comment from Kconfig
In-Reply-To: <1349205048-22228-1-git-send-email-swarren@wwwdotorg.org>
References: <1349205048-22228-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1349205048-22228-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Since the complete conversion to device tree, there are no board-
specific Kconfig options left, so remove the useless Kconfig entry.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 5f3c03b..1219d87 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -57,8 +57,6 @@ config TEGRA_AHB
 	  which controls AHB bus master arbitration and some
 	  perfomance parameters(priority, prefech size).
 
-comment "Tegra board type"
-
 choice
         prompt "Default low-level debug console UART"
         default TEGRA_DEBUG_UART_NONE
-- 
1.7.0.4
