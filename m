From: festevam@gmail.com (Fabio Estevam)
Date: Sat,  3 Mar 2018 17:05:47 -0300
Subject: [PATCH 1/2] ARM: imx_v4_v5_defconfig: Re-sync defconfig
Message-ID: <1520107548-31619-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>>

Re-sync the defconfig by doing:

make savedefconfig
cp defconfig arch/arm/configs/imx_v4_v5_defconfig

So keep it in sync to help further changes in defconfig.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/configs/imx_v4_v5_defconfig | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index ca0f13ca..893d0a0 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -1,7 +1,6 @@
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
-CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
@@ -78,7 +77,6 @@ CONFIG_SMC91X=y
 CONFIG_SMC911X=y
 CONFIG_SMSC911X=y
 CONFIG_SMSC_PHY=y
-# CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_IMX=y
@@ -105,8 +103,8 @@ CONFIG_HWMON=m
 CONFIG_SENSORS_MC13783_ADC=m
 CONFIG_WATCHDOG=y
 CONFIG_IMX2_WDT=y
-CONFIG_MFD_MX25_TSADC=y
 CONFIG_MFD_MC13XXX_SPI=y
+CONFIG_MFD_MX25_TSADC=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_GPIO=y
@@ -116,10 +114,8 @@ CONFIG_MEDIA_SUPPORT=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_SOC_CAMERA=y
-CONFIG_VIDEO_MX2=y
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_CODA=y
-CONFIG_SOC_CAMERA_OV2640=y
 CONFIG_FB=y
 CONFIG_FB_IMX=y
 CONFIG_LCD_L4F00242T03=y
-- 
2.7.4
