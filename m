From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 23 May 2012 11:42:53 +0530
Subject: [PATCH V2 1/2] ARM: tegra: config: enable TPS65910 drivers
Message-ID: <1337753574-32699-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable TPS65910 mfd, gpio and regulator drivers.
This is the PMIC module for Tegra30 based cardhu
platform.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
No change from V1.

 arch/arm/configs/tegra_defconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 1198dd6..26ad2b4 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -106,16 +106,19 @@ CONFIG_I2C=y
 CONFIG_I2C_TEGRA=y
 CONFIG_SPI=y
 CONFIG_SPI_TEGRA=y
+CONFIG_GPIO_TPS65910=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_BATTERY_SBS=y
 CONFIG_SENSORS_LM90=y
 CONFIG_MFD_TPS6586X=y
+CONFIG_MFD_TPS65910=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_TPS62360=y
 CONFIG_REGULATOR_TPS6586X=y
+CONFIG_REGULATOR_TPS65910=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 # CONFIG_SND_SUPPORT_OLD_API is not set
-- 
1.7.1.1
