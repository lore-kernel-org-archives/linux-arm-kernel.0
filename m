From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 8 Oct 2013 12:50:08 +0800
Subject: [PATCH V2 6/6] ARM: tegra: enable Tegra124 support
In-Reply-To: <1381207808-14734-1-git-send-email-josephl@nvidia.com>
References: <1381207808-14734-1-git-send-email-josephl@nvidia.com>
Message-ID: <1381207808-14734-7-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Tegra124 support in tegra_defconfig file.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* no change
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index ec4f6e7..4934295 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -27,6 +27,7 @@ CONFIG_ARCH_TEGRA=y
 CONFIG_ARCH_TEGRA_2x_SOC=y
 CONFIG_ARCH_TEGRA_3x_SOC=y
 CONFIG_ARCH_TEGRA_114_SOC=y
+CONFIG_ARCH_TEGRA_124_SOC=y
 CONFIG_TEGRA_EMC_SCALING_ENABLE=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
-- 
1.8.4
