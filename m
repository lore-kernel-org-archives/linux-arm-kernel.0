From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 27 Mar 2013 12:46:57 +0900
Subject: [PATCH 2/2] ARM: shmobile: marzen: defconfig: enable GPIO LEDs driver
In-Reply-To: <1364356017-25890-1-git-send-email-horms+renesas@verge.net.au>
References: <1364356017-25890-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364356017-25890-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the code added to the marzen board in
"ARM: shmobile: marzen: Add GPIO LEDs".

Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/marzen_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index 4b183d1..47e4d27 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -89,6 +89,9 @@ CONFIG_USB_OHCI_HCD=y
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
