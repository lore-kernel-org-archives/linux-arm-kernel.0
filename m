From: yegorslists@googlemail.com (yegorslists at googlemail.com)
Date: Fri,  8 Apr 2016 12:11:59 +0200
Subject: [PATCH] ARM: omap2plus_defconfig: Enable MDIO Bus/PHY emulation
 support
Message-ID: <1460110319-31525-1-git-send-email-yegorslists@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yegor Yefremov <yegorslists@googlemail.com>

MDIO Bus/PHY emulation with fixed speed/link PHYs will be used in
Baltos iR5221 devices to connect to ICPlus IP175D switch IC.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 156bc88..e5a2782 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -178,6 +178,7 @@ CONFIG_TI_CPTS=y
 # CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_AT803X_PHY=y
 CONFIG_SMSC_PHY=y
+CONFIG_FIXED_PHY=y
 CONFIG_USB_USBNET=m
 CONFIG_USB_NET_SMSC75XX=m
 CONFIG_USB_NET_SMSC95XX=m
-- 
2.1.4
