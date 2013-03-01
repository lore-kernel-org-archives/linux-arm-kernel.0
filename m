From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  1 Mar 2013 09:42:33 -0300
Subject: [PATCH] ARM: mxs_defconfig: Select watchdog driver
Message-ID: <1362141754-11254-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Select watchdog driver.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/mxs_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index fbbc5bb..f662604 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -99,6 +99,8 @@ CONFIG_SPI_MXS=y
 CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+CONFIG_STMP3XXX_RTC_WATCHDOG=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_FB=y
-- 
1.7.9.5
