From: cooloney@gmail.com (Bryan Wu)
Date: Fri,  7 Feb 2014 15:54:57 -0800
Subject: [PATCH 1/2] ARM: tegra: enable I2C Mux driver for PCA9546 in defconfig
Message-ID: <1391817298-10600-1-git-send-email-pengw@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCA9546 is used in Cardhu Tegra30 board to connect to 3 cameras.
Enabling this driver for Tegra V4L2 soc camera driver and camera
sensor drivers.

Signed-off-by: Bryan Wu <pengw@nvidia.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 995d434..efcf15f 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -125,6 +125,7 @@ CONFIG_SERIAL_TEGRA=y
 CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_I2C_COMPAT is not set
+CONFIG_I2C_MUX_PCA954x=y
 CONFIG_I2C_MUX_PINCTRL=y
 CONFIG_I2C_TEGRA=y
 CONFIG_SPI=y
-- 
1.8.3.2
