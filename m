From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 7 Jan 2014 14:09:59 +0530
Subject: [PATCH] ARM: config: enable ams AS3722 power reset driver
Message-ID: <1389084000-17033-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ams AS3722 is used as system PMIC for Tegra124 based Venice2.
Enable ams AS3722 power reset driver for enabling power off
system using PMIC.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/configs/tegra_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 5fdc9a0..b17d301 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -142,6 +142,7 @@ CONFIG_POWER_SUPPLY=y
 CONFIG_BATTERY_SBS=y
 CONFIG_CHARGER_TPS65090=y
 CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_AS3722=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_SENSORS_LM90=y
 CONFIG_MFD_AS3722=y
-- 
1.7.9.5
