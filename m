From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 12 Jan 2016 20:10:26 +0100
Subject: [PATCH net-next 02/10] ARM: mvebu: enable SRAM support in
 mvebu_v7_defconfig
In-Reply-To: <1452625834-22166-1-git-send-email-gregory.clement@free-electrons.com>
References: <1452625834-22166-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1452625834-22166-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcin Wojtas <mw@semihalf.com>

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index c6729bf0a8dd..fe57e20ba200 100644
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
2.5.0
