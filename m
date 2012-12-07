From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu,  6 Dec 2012 17:21:12 -0700
Subject: [PATCH 2/2] ARM: tegra: enable gpio-poweroff driver in defconfig
In-Reply-To: <1354839672-31187-1-git-send-email-swarren@wwwdotorg.org>
References: <1354839672-31187-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1354839672-31187-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/configs/tegra_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index a7827fd..a568c34 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -127,6 +127,8 @@ CONFIG_GPIO_TPS6586X=y
 CONFIG_GPIO_TPS65910=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_BATTERY_SBS=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_GPIO=y
 CONFIG_SENSORS_LM90=y
 CONFIG_MFD_TPS6586X=y
 CONFIG_MFD_TPS65910=y
-- 
1.7.10.4
