From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 7 Apr 2016 17:16:20 +0530
Subject: [PATCH] ARM: davinci_all_defconfig: enable GPIO_SYSFS
Message-ID: <1460029580-1615-1-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_GPIO_SYSFS provides a convenient way to
access GPIOs from userspace.

Enable it for DaVinci.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/configs/davinci_all_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index d1b3799c08cc..83b9acae1367 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -119,6 +119,7 @@ CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_DAVINCI=y
 CONFIG_PINCTRL_SINGLE=y
+CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_PCF857X=y
 CONFIG_WATCHDOG=y
 CONFIG_DAVINCI_WATCHDOG=m
-- 
2.6.3
