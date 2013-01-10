From: anilkumar.v@ti.com (Kumar, Anil)
Date: Thu, 10 Jan 2013 16:00:37 +0530
Subject: [PATCH V3 2/3] ARM: davinci: da8xx defconfig: enable pinctrl config
 option
In-Reply-To: <1357813838-26511-1-git-send-email-anilkumar.v@ti.com>
References: <1357813838-26511-1-git-send-email-anilkumar.v@ti.com>
Message-ID: <1357813838-26511-3-git-send-email-anilkumar.v@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable pinctrl related config option in da8xx_omapl_defconfig

Signed-off-by: Kumar, Anil <anilkumar.v@ti.com>
---
:100644 100644 f292239... 0892db4... M	arch/arm/configs/da8xx_omapl_defconfig
 arch/arm/configs/da8xx_omapl_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/da8xx_omapl_defconfig b/arch/arm/configs/da8xx_omapl_defconfig
index f292239..0892db4 100644
--- a/arch/arm/configs/da8xx_omapl_defconfig
+++ b/arch/arm/configs/da8xx_omapl_defconfig
@@ -81,6 +81,7 @@ CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_DAVINCI=y
+CONFIG_PINCTRL_SINGLE=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_REGULATOR=y
-- 
1.7.4.1
