From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Wed, 10 Jun 2015 15:42:33 -0700
Subject: [PATCH] ARM: keystone: defconfig: enable netcp driver by default
Message-ID: <1433976153-3522-1-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Murali Karicheri <m-karicheri2@ti.com>

Enable netcp driver in defconfig for keystone SoCs.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Santosh Shilimkar <ssantosh@kernel.org>
---
 arch/arm/configs/keystone_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index f8a1c8f..95ce128 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -123,6 +123,9 @@ CONFIG_EEPROM_AT24=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
+CONFIG_TI_KEYSTONE_NETCP=y
+CONFIG_TI_KEYSTONE_NETCP_ETHSS=y
+CONFIG_PHYLIB=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
@@ -152,6 +155,9 @@ CONFIG_USB_DWC3_VERBOSE=y
 CONFIG_KEYSTONE_USB_PHY=y
 CONFIG_DMADEVICES=y
 CONFIG_TI_EDMA=y
+CONFIG_SOC_TI=y
+CONFIG_KEYSTONE_NAVIGATOR_QMSS=y
+CONFIG_KEYSTONE_NAVIGATOR_DMA=y
 CONFIG_MEMORY=y
 CONFIG_TI_AEMIF=y
 CONFIG_EXT4_FS=y
-- 
1.9.1
