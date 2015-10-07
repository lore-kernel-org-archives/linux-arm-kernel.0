From: nm@ti.com (Nishanth Menon)
Date: Wed, 7 Oct 2015 14:28:09 -0500
Subject: [PATCH] ARM: configs: keystone: Add ramdisk support
Message-ID: <1444246089-1417-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ramdisk support to allow for minimal kernel to be supported.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Based on next-20151007 (with SPI disabled)
test: http://pastebin.ubuntu.com/12707715/

 arch/arm/configs/keystone_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 5bcc9cf9d8f1..836674b74b4f 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -124,6 +124,8 @@ CONFIG_MTD_NAND_DAVINCI=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=8096
 CONFIG_EEPROM_AT24=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
-- 
2.1.4
