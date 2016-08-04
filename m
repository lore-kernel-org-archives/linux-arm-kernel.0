From: jaz@semihalf.com (Grzegorz Jaszczyk)
Date: Thu,  4 Aug 2016 12:14:05 +0200
Subject: [PATCH v2 02/17] ARM: mvebu: enable UBI and UBIFS in
 mvebu_v7_defconfig
In-Reply-To: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
References: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
Message-ID: <1470305660-6601-3-git-send-email-jaz@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UBIFS is commonly used on Marvell EBU v7 platforms to store the root
file-system, so it makes sense to have those options enabled by default
in mvebu_v7_defconfig.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index f43a7aa..f1a0e25 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -60,6 +60,7 @@ CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_PXA3xx=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_SRAM=y
+CONFIG_MTD_UBI=y
 CONFIG_EEPROM_AT24=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
@@ -141,6 +142,7 @@ CONFIG_UDF_FS=m
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
+CONFIG_UBIFS_FS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
-- 
1.8.3.1
