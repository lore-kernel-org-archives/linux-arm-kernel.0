From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 23 Apr 2015 15:37:29 -0400
Subject: [PATCH 1/4] ARM: keystone: defconfig: enable netcp driver by default
In-Reply-To: <1429817852-27938-1-git-send-email-m-karicheri2@ti.com>
References: <1429817852-27938-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1429817852-27938-2-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable netcp driver in defconfig for keystone SoCs.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 arch/arm/configs/keystone_defconfig |    6 ++++++
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
1.7.9.5
