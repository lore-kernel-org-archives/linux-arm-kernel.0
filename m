From: bernhard.nortmann@web.de (Bernhard Nortmann)
Date: Thu, 25 Jun 2015 15:21:33 +0200
Subject: [PATCH] Remove deprecated symbol from defconfig files
Message-ID: <1435238493-32614-1-git-send-email-bernhard.nortmann@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to re-apply the changes from
https://groups.google.com/forum/#!topic/linux-sunxi/Hhx2CR2YWhI

It removes the deprecated/obsolete symbol CONFIG_POWER_RESET_SUN6I
from multi_v7_defconfig and sunxi_defconfig in arch/arm/configs/.

mripard's tree incorporated the changes, but they somehow didn't
make it upstream. The symbol is still present as of v4.1.

Signed-off-by: Bernhard Nortmann <bernhard.nortmann@web.de>
---
 arch/arm/configs/multi_v7_defconfig | 1 -
 arch/arm/configs/sunxi_defconfig    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index fbbb191..0d686b1 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -322,7 +322,6 @@ CONFIG_POWER_RESET_AS3722=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_POWER_RESET_GPIO_RESTART=y
 CONFIG_POWER_RESET_KEYSTONE=y
-CONFIG_POWER_RESET_SUN6I=y
 CONFIG_POWER_RESET_RMOBILE=y
 CONFIG_SENSORS_LM90=y
 CONFIG_SENSORS_LM95245=y
diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 8ecba00..2c7af0a 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -77,7 +77,6 @@ CONFIG_SPI_SUN6I=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_POWER_RESET=y
-CONFIG_POWER_RESET_SUN6I=y
 CONFIG_THERMAL=y
 CONFIG_CPU_THERMAL=y
 CONFIG_WATCHDOG=y
-- 
2.0.5
