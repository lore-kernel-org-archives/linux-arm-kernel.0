From: ahaslam@baylibre.com (Axel Haslam)
Date: Mon, 21 Nov 2016 18:01:31 +0100
Subject: [PATCH] ARM: davinci_all_defconfig: Enable OHCI as module
Message-ID: <20161121170131.30157-1-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the davinci ohci driver as a module for usb
tested with the omap138-lcdk hawk board.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/configs/davinci_all_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index b5e978f..b9bbbbd 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -157,6 +157,7 @@ CONFIG_HID_SONY=m
 CONFIG_HID_SUNPLUS=m
 CONFIG_USB=m
 CONFIG_USB_MON=m
+CONFIG_USB_OHCI_HCD=m
 CONFIG_USB_STORAGE=m
 CONFIG_USB_MUSB_HDRC=m
 CONFIG_MUSB_PIO_ONLY=y
-- 
2.9.3
