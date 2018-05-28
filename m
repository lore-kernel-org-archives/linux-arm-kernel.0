From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Mon, 28 May 2018 17:13:57 +0200
Subject: [PATCH v2] ARM: multi_v7_defconfig: Add Marvell NAND controller
 support
Message-ID: <20180528151357.29203-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Marvell NAND controller support used by some Marvell Armada based
boards.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
Changelog v1 -> v2:

 - Rebased on v4.17-rc1 (Dropped "ARM: multi_v7_defconfig: Update with
   current configuration")

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e6b3c96d4c09..3fcb17b38f50 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -210,6 +210,7 @@ CONFIG_MTD_NAND_DENALI_DT=y
 CONFIG_MTD_NAND_OMAP2=y
 CONFIG_MTD_NAND_OMAP_BCH=y
 CONFIG_MTD_NAND_ATMEL=y
+CONFIG_MTD_NAND_MARVELL=y
 CONFIG_MTD_NAND_GPMI_NAND=y
 CONFIG_MTD_NAND_BRCMNAND=y
 CONFIG_MTD_NAND_VF610_NFC=y
-- 
2.17.0
