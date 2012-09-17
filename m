From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Sep 2012 13:34:46 +0800
Subject: [PATCH 17/34] usb: ehci-mxc: remove unneeded mach/hardware.h inclusion
In-Reply-To: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1347860103-4141-18-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The inclusion of mach/hardware.h is not used by the driver at all.
Remove it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ehci-mxc.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index a6e2ea4..e5e9856 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -24,7 +24,6 @@
 #include <linux/usb/ulpi.h>
 #include <linux/slab.h>
 
-#include <mach/hardware.h>
 #include <linux/platform_data/usb-ehci-mxc.h>
 
 #include <asm/mach-types.h>
-- 
1.7.9.5
