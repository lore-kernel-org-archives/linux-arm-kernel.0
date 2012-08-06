From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  6 Aug 2012 01:43:19 -0300
Subject: [PATCH v2] ARM: mxs_defconfig: Enable USB host
Message-ID: <1344228199-16231-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Enable USB host.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Use savedefconfig to generate a minimal config
 arch/arm/configs/mxs_defconfig |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index ccdb635..e3487e4 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -95,7 +95,6 @@ CONFIG_GPIO_SYSFS=y
 # CONFIG_MFD_SUPPORT is not set
 CONFIG_DISPLAY_SUPPORT=m
 # CONFIG_HID_SUPPORT is not set
-# CONFIG_USB_SUPPORT is not set
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_TIMER=y
@@ -110,6 +109,13 @@ CONFIG_SND_SOC_I2C_AND_SPI=y
 CONFIG_SND_SOC_SGTL5000=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_USB=y
+CONFIG_USB_CHIPIDEA=y
+CONFIG_USB_CHIPIDEA_HOST=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_MXS_PHY=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
 CONFIG_MMC=y
 CONFIG_MMC_MXS=y
 CONFIG_RTC_CLASS=y
-- 
1.7.1
