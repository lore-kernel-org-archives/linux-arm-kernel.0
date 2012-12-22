From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Sun, 23 Dec 2012 02:23:05 +0530
Subject: [PATCH] ARM: tegra: config: Add TPS6586X RTC config
Message-ID: <1356209585-6506-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable CONFIG_RTC_DRV_TPS6586X to have RTC driver support for
ventana, harmony etc.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/configs/tegra_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index a7827fd..b88ec5a 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -186,6 +186,7 @@ CONFIG_RTC_INTF_SYSFS=y
 CONFIG_RTC_INTF_PROC=y
 CONFIG_RTC_INTF_DEV=y
 CONFIG_RTC_DRV_MAX8907=y
+CONFIG_RTC_DRV_TPS6586X=y
 CONFIG_RTC_DRV_TPS65910=y
 CONFIG_RTC_DRV_EM3027=y
 CONFIG_RTC_DRV_TEGRA=y
-- 
1.7.1.1
