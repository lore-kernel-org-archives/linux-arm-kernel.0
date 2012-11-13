From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 13 Nov 2012 10:33:41 +0530
Subject: [PATCH 3/3] ARM: config: tegra: enable SFLASH controller driver
In-Reply-To: <1352783021-25393-1-git-send-email-ldewangan@nvidia.com>
References: <1352783021-25393-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1352783021-25393-4-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/configs/tegra_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 9dac09b..39107b1 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -120,6 +120,7 @@ CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PINCTRL=y
 CONFIG_I2C_TEGRA=y
 CONFIG_SPI=y
+CONFIG_SPI_TEGRA20_SFLASH=y
 CONFIG_SPI_TEGRA20_SLINK=y
 CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_GPIO_TPS6586X=y
-- 
1.7.1.1
