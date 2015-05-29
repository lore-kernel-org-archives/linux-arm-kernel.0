From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Fri, 29 May 2015 17:39:32 +0530
Subject: [PATCH] ARM: tegra: enable REGULATOR_MAX8973
Message-ID: <1432901372-17012-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable config REGULATOR_MAX8973 for regulator device MAX77621
as this device is used on some of tegra platform.

The driver MAX8973 is compatible with max77621.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index f4d8711..9b113bd 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -171,6 +171,7 @@ CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_AS3722=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_MAX8907=y
+CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_PALMAS=y
 CONFIG_REGULATOR_TPS51632=y
 CONFIG_REGULATOR_TPS62360=y
-- 
2.1.4
