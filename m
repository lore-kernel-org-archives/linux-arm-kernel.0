From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 26 Aug 2016 17:41:37 +0100
Subject: [PATCH 2/2] usb: ohci-sa1111: remove mach/hardware.h include
Message-ID: <E1bdKCH-0001lf-7O@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mach/hardware.h include doesn't seem to be necessary to build
ohci-sa1111, so let's remove it to kill off an unnecessary platform
specific include.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/usb/host/ohci-sa1111.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/host/ohci-sa1111.c b/drivers/usb/host/ohci-sa1111.c
index 6dc5eaed8551..3a9ea32508df 100644
--- a/drivers/usb/host/ohci-sa1111.c
+++ b/drivers/usb/host/ohci-sa1111.c
@@ -13,7 +13,6 @@
  * This file is licenced under the GPL.
  */
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/hardware/sa1111.h>
 
-- 
2.1.0
