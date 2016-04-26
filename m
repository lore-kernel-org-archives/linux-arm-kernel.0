From: tony@atomide.com (Tony Lindgren)
Date: Tue, 26 Apr 2016 10:32:16 -0700
Subject: [PATCH] ARM: omap2plus_defconfig: Enable twl6030 USB phy as loadable
 module
Message-ID: <1461691936-2323-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is in use on omap4 boards.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index c48cbd7..5bd5d36 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -364,6 +364,7 @@ CONFIG_USB_SERIAL_FTDI_SIO=m
 CONFIG_USB_SERIAL_PL2303=m
 CONFIG_USB_TEST=m
 CONFIG_AM335X_PHY_USB=y
+CONFIG_TWL6030_USB=m
 CONFIG_USB_GADGET=m
 CONFIG_USB_GADGET_DEBUG=y
 CONFIG_USB_GADGET_DEBUG_FILES=y
-- 
2.8.1
