From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 13 Apr 2018 19:27:54 +0200
Subject: [PATCH 5/9] ARM: bcm2835_defconfig: Enable LAN78XX driver
In-Reply-To: <1523640478-4448-1-git-send-email-stefan.wahren@i2se.com>
References: <1523640478-4448-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1523640478-4448-6-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the necessary driver for Raspberry Pi 3 B+,
which has a LAN7515 chip.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/configs/bcm2835_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 8682b15..9fae57c 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -64,6 +64,7 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_SCAN_ASYNC=y
 CONFIG_NETDEVICES=y
+CONFIG_USB_LAN78XX=y
 CONFIG_USB_USBNET=y
 CONFIG_USB_NET_SMSC95XX=y
 CONFIG_BRCMFMAC=m
-- 
2.7.4
