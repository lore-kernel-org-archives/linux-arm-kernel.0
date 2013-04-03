From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed,  3 Apr 2013 16:45:18 +0200
Subject: [PATCH v3 12/12] ARM: tegra: Update default configuration (PCIe)
In-Reply-To: <1365000318-28256-1-git-send-email-thierry.reding@avionic-design.de>
References: <1365000318-28256-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1365000318-28256-13-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable PCI and MSI support as well as the new Tegra PCIe controller
driver.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 arch/arm/configs/tegra_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 2b42a2c..6cedaa1 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -26,8 +26,10 @@ CONFIG_GPIO_PCA953X=y
 CONFIG_ARCH_TEGRA_2x_SOC=y
 CONFIG_ARCH_TEGRA_3x_SOC=y
 CONFIG_ARCH_TEGRA_114_SOC=y
-CONFIG_TEGRA_PCI=y
 CONFIG_TEGRA_EMC_SCALING_ENABLE=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCI_TEGRA=y
 CONFIG_SMP=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
-- 
1.8.2
