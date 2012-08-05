From: festevam@gmail.com (Fabio Estevam)
Date: Sun,  5 Aug 2012 14:04:18 -0300
Subject: [PATCH] ARM: mxs_defconfig: Enable USB host
Message-ID: <1344186258-30841-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Enable USB host.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/mxs_defconfig |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index ccdb635..73842f9 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -95,7 +95,7 @@ CONFIG_GPIO_SYSFS=y
 # CONFIG_MFD_SUPPORT is not set
 CONFIG_DISPLAY_SUPPORT=m
 # CONFIG_HID_SUPPORT is not set
-# CONFIG_USB_SUPPORT is not set
+CONFIG_USB_SUPPORT=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_TIMER=y
@@ -110,6 +110,18 @@ CONFIG_SND_SOC_I2C_AND_SPI=y
 CONFIG_SND_SOC_SGTL5000=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_USB_COMMON=y
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
+CONFIG_USB_EHCI_TT_NEWSCHED=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_OTG_UTILS=y
+CONFIG_USB_MXS_PHY=y
+CONFIG_USB_CHIPIDEA=y
+CONFIG_USB_CHIPIDEA_HOST=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
 CONFIG_MMC=y
 CONFIG_MMC_MXS=y
 CONFIG_RTC_CLASS=y
-- 
1.7.1
