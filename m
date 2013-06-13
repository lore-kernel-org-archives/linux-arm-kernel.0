From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Jun 2013 16:00:10 +0900
Subject: [PATCH 2/3] ARM: shmobile: bockw defconfig: add M25P80 support
In-Reply-To: <1371106811-25223-1-git-send-email-horms+renesas@verge.net.au>
References: <1371106811-25223-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371106811-25223-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/bockw_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
index cb7638d..55e00ff 100644
--- a/arch/arm/configs/bockw_defconfig
+++ b/arch/arm/configs/bockw_defconfig
@@ -49,6 +49,12 @@ CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_FW_LOADER is not set
+CONFIG_MTD=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_M25P80=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
@@ -76,6 +82,8 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_HWMON is not set
 CONFIG_I2C=y
 CONFIG_I2C_RCAR=y
+CONFIG_SPI=y
+CONFIG_SPI_SH_HSPI=y
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_EHCI_HCD=y
-- 
1.8.2.1
