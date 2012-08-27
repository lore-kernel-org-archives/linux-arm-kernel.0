From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 27 Aug 2012 13:23:29 -0300
Subject: [PATCH 3/3] ARM: mxs_defconfig: Add SPI and LRADC support
In-Reply-To: <1346084609-31407-1-git-send-email-fabio.estevam@freescale.com>
References: <1346084609-31407-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1346084609-31407-3-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SPI and LRADC support.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/mxs_defconfig |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 36d60dd..d2910f9 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -53,6 +53,9 @@ CONFIG_DEVTMPFS=y
 # CONFIG_FIRMWARE_IN_KERNEL is not set
 # CONFIG_BLK_DEV is not set
 CONFIG_MTD=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_DATAFLASH=y
+CONFIG_MTD_M25P80
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_GPMI_NAND=y
 CONFIG_NETDEVICES=y
@@ -82,6 +85,7 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MXS=y
 CONFIG_SPI=y
 CONFIG_SPI_GPIO=m
+CONFIG_SPI_MXS=y
 CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
@@ -110,7 +114,11 @@ CONFIG_RTC_DRV_DS1307=m
 CONFIG_RTC_DRV_STMP=y
 CONFIG_DMADEVICES=y
 CONFIG_MXS_DMA=y
+CONFIG_STAGING=y
+CONFIG_MXS_LRADC=y
+CONFIG_IIO_SYSFS_TRIGGER=y
 CONFIG_COMMON_CLK_DEBUG=y
+CONFIG_IIO=y
 CONFIG_EXT3_FS=y
 # CONFIG_DNOTIFY is not set
 CONFIG_FSCACHE=m
-- 
1.7.9.5
