From: tony@atomide.com (Tony Lindgren)
Date: Wed, 16 Dec 2009 11:10:06 -0800
Subject: [PATCH 2/4] USB ehci: replace mach header with plat
In-Reply-To: <20091216190601.30032.91535.stgit@localhost>
References: <20091216190601.30032.91535.stgit@localhost>
Message-ID: <20091216191006.30032.75638.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Weber <weber@corscience.de>

Replace the mach/usb.h with plat/usb.h

Cc: linux-usb-devel at lists.sourceforge.net
Signed-off-by: Thomas Weber <weber@corscience.de>
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/host/ehci-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 12f1ad2..74d07f4 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -37,7 +37,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
-#include <mach/usb.h>
+#include <plat/usb.h>
 
 /*
  * OMAP USBHOST Register addresses: VIRTUAL ADDRESSES
