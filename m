From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 30 Oct 2012 12:35:26 +0530
Subject: [PATCH V3 4/4] ARM: tegra: config: enable spi driver for Tegra SLINK
 controller
In-Reply-To: <1351580726-17350-1-git-send-email-ldewangan@nvidia.com>
References: <1351580726-17350-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1351580726-17350-5-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
No change from V1 and V2.

 arch/arm/configs/tegra_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index fb29680..60e1b2e 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -117,7 +117,7 @@ CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PINCTRL=y
 CONFIG_I2C_TEGRA=y
 CONFIG_SPI=y
-CONFIG_SPI_TEGRA=y
+CONFIG_SPI_TEGRA20_SLINK=y
 CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_GPIO_TPS6586X=y
 CONFIG_GPIO_TPS65910=y
-- 
1.7.1.1
