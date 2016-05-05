From: andre.przywara@arm.com (Andre Przywara)
Date: Thu,  5 May 2016 10:44:18 +0100
Subject: [PATCH] arm64: defconfig: Add Juno SATA controller
Message-ID: <1462441458-24387-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM Juno (r1 and r2) boards feature a SATA controller soldered
on the board and connected to the PCI bus.
Add the respective driver to defconfig to get hard disks supported out
of the box on the Junos.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a44ef99..c7f4202 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -103,6 +103,7 @@ CONFIG_AHCI_CEVA=y
 CONFIG_AHCI_MVEBU=y
 CONFIG_AHCI_XGENE=y
 CONFIG_SATA_RCAR=y
+CONFIG_SATA_SIL24=y
 CONFIG_PATA_PLATFORM=y
 CONFIG_PATA_OF_PLATFORM=y
 CONFIG_NETDEVICES=y
-- 
2.7.3
