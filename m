From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 16 Nov 2011 20:31:55 +0100
Subject: [PATCH] ARM: ux500: update defconfig
Message-ID: <1321471915-20899-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This updates the Ux500 defconfig with the new drivers for HWSEM
and AB5500 core that were merged in the 3.2 cycle.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/u8500_defconfig |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 97d31a4..2d7b6e7 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -10,7 +10,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_U8500=y
 CONFIG_UX500_SOC_DB5500=y
 CONFIG_UX500_SOC_DB8500=y
-CONFIG_MACH_U8500=y
+CONFIG_MACH_HREFV60=y
 CONFIG_MACH_SNOWBALL=y
 CONFIG_MACH_U5500=y
 CONFIG_NO_HZ=y
@@ -24,6 +24,7 @@ CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_VFP=y
 CONFIG_NEON=y
+CONFIG_PM_RUNTIME=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -41,11 +42,8 @@ CONFIG_MISC_DEVICES=y
 CONFIG_AB8500_PWM=y
 CONFIG_SENSORS_BH1780=y
 CONFIG_NETDEVICES=y
-CONFIG_SMSC_PHY=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMSC911X=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
+CONFIG_SMSC_PHY=y
 # CONFIG_WLAN is not set
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=y
@@ -72,15 +70,12 @@ CONFIG_SPI=y
 CONFIG_SPI_PL022=y
 CONFIG_GPIO_STMPE=y
 CONFIG_GPIO_TC3589X=y
-# CONFIG_HWMON is not set
 CONFIG_MFD_STMPE=y
 CONFIG_MFD_TC3589X=y
+CONFIG_AB5500_CORE=y
 CONFIG_AB8500_CORE=y
 CONFIG_REGULATOR_AB8500=y
 # CONFIG_HID_SUPPORT is not set
-CONFIG_USB_MUSB_HDRC=y
-CONFIG_USB_GADGET_MUSB_HDRC=y
-CONFIG_MUSB_PIO_ONLY=y
 CONFIG_USB_GADGET=y
 CONFIG_AB8500_USB=y
 CONFIG_MMC=y
@@ -97,6 +92,7 @@ CONFIG_DMADEVICES=y
 CONFIG_STE_DMA40=y
 CONFIG_STAGING=y
 CONFIG_TOUCHSCREEN_SYNAPTICS_I2C_RMI4=y
+CONFIG_HSEM_U8500=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-- 
1.7.3.2
