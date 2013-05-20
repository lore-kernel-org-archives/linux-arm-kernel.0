From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 20 May 2013 13:12:35 -0600
Subject: [PATCH] ARM: tegra: config: enable TPS65090 charger
Message-ID: <1369077155-1483-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This is part of the TPS65090 MFD chip on the Dalmore board.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/configs/tegra_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 9de7693..4dbcd9f 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -130,6 +130,7 @@ CONFIG_GPIO_TPS6586X=y
 CONFIG_GPIO_TPS65910=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_BATTERY_SBS=y
+CONFIG_CHARGER_TPS65090=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_SENSORS_LM90=y
-- 
1.7.10.4
