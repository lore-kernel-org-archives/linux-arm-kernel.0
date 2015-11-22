From: mw@semihalf.com (Marcin Wojtas)
Date: Sun, 22 Nov 2015 08:53:54 +0100
Subject: [PATCH 08/13] ARM: mvebu: enable SRAM support in mvebu_v7_defconfig
In-Reply-To: <1448178839-3541-1-git-send-email-mw@semihalf.com>
References: <1448178839-3541-1-git-send-email-mw@semihalf.com>
Message-ID: <1448178839-3541-9-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index c6729bf..fe57e20 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -58,6 +58,7 @@ CONFIG_MTD_M25P80=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_PXA3xx=y
 CONFIG_MTD_SPI_NOR=y
+CONFIG_SRAM=y
 CONFIG_EEPROM_AT24=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
-- 
1.8.3.1
