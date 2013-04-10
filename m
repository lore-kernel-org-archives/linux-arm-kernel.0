From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 10 Apr 2013 17:18:02 +0530
Subject: [PATCH 1/2] ARM: config: tegra: enable T114 SPI
Message-ID: <1365594483-20651-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nvidia Tegra114 has the new spi controller whose driver
is not compatible with older SoCs. The new driver is added
for Tegra114 spi controller.

Enabling the config of this driver.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/configs/tegra_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index a5f0485..8a50fc8 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -121,6 +121,7 @@ CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PINCTRL=y
 CONFIG_I2C_TEGRA=y
 CONFIG_SPI=y
+CONFIG_SPI_TEGRA114=y
 CONFIG_SPI_TEGRA20_SFLASH=y
 CONFIG_SPI_TEGRA20_SLINK=y
 CONFIG_GPIO_PCA953X_IRQ=y
-- 
1.7.1.1
