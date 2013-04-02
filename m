From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 13:31:33 +0900
Subject: [PATCH 2/3] ARM: shmobile: marzen: defconfig: enable GPIO LEDs driver
In-Reply-To: <1364877094-1508-1-git-send-email-horms+renesas@verge.net.au>
References: <1364877094-1508-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364877094-1508-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the code added to the marzen board in
"ARM: shmobile: marzen: Add GPIO LEDs".

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/marzen_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index 9f65975..494e70a 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -93,6 +93,9 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
 CONFIG_UIO=y
 CONFIG_UIO_PDRV_GENIRQ=y
 # CONFIG_IOMMU_SUPPORT is not set
-- 
1.7.10.4
