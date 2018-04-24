From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Tue, 24 Apr 2018 10:15:28 +0200
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Add Marvel NAND controller
 support
In-Reply-To: <20180424081528.25883-1-gregory.clement@bootlin.com>
References: <20180424081528.25883-1-gregory.clement@bootlin.com>
Message-ID: <20180424081528.25883-3-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Marvell NAND controller support used by some Marvell Armada based
boards.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6b7b7da20e81..2b008248fb52 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -182,6 +182,7 @@ CONFIG_MTD_NAND_DENALI_DT=y
 CONFIG_MTD_NAND_OMAP2=y
 CONFIG_MTD_NAND_OMAP_BCH=y
 CONFIG_MTD_NAND_ATMEL=y
+CONFIG_MTD_NAND_MARVELL=y
 CONFIG_MTD_NAND_GPMI_NAND=y
 CONFIG_MTD_NAND_BRCMNAND=y
 CONFIG_MTD_NAND_VF610_NFC=y
-- 
2.16.3
