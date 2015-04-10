From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Fri, 10 Apr 2015 23:36:01 +0200
Subject: [PATCH 6/9] ARM: tegra: enable watchdog in defconfig
In-Reply-To: <cover.1428700856.git.marcel.ziswiler@toradex.com>
References: <cover.1428700856.git.marcel.ziswiler@toradex.com>
Message-ID: <924e2172b8ac0d443ca6b667793ec70b0a44d127.1428700856.git.marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---
 arch/arm/configs/tegra_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index d199eb2..18047c4 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -154,6 +154,8 @@ CONFIG_POWER_RESET_AS3722=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_SENSORS_LM90=y
 CONFIG_SENSORS_LM95245=y
+CONFIG_WATCHDOG=y
+CONFIG_TEGRA_WATCHDOG=y
 CONFIG_MFD_AS3722=y
 CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_SPI=y
-- 
1.9.3
