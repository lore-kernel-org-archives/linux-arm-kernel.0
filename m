From: rogerq@ti.com (Roger Quadros)
Date: Mon, 24 Nov 2014 13:41:37 +0200
Subject: [PATCH] ARM: omap2plus_defconfig: Enable AHCI_PLATFORM driver
Message-ID: <1416829297-12664-1-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP5 and DRA7 platforms need the AHCI platform driver
for SATA support.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 87a5c11..d75358a 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -127,6 +127,8 @@ CONFIG_SRAM=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_SCAN_ASYNC=y
+CONFIG_ATA=y
+CONFIG_SATA_AHCI_PLATFORM=y
 CONFIG_MD=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_ARC is not set
-- 
1.8.3.2
