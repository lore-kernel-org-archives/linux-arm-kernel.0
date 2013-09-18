From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 18 Sep 2013 18:37:21 +0530
Subject: [PATCH 1/2] ARM: tegra: enable PALMAS_PINCTRL config
Message-ID: <1379509642-19227-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PALMAS PMIC is used on Dalmore platform. Enable the pincontrol
driver for Palmas to configure pins of Palmas on desired state.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Reposting as the patch sent earlier was miss the merge date.

 arch/arm/configs/tegra_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index bb16a04..3be2122 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -130,6 +130,7 @@ CONFIG_SPI=y
 CONFIG_SPI_TEGRA114=y
 CONFIG_SPI_TEGRA20_SFLASH=y
 CONFIG_SPI_TEGRA20_SLINK=y
+CONFIG_PINCTRL_PALMAS=y
 CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_GPIO_PALMAS=y
 CONFIG_GPIO_TPS6586X=y
-- 
1.7.1.1
