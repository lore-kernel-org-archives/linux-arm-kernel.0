From: michael@walle.cc (Michael Walle)
Date: Sun, 21 Oct 2012 01:34:53 +0200
Subject: [PATCH 1/2] ARM: kirkwood: cleanup lsxl board includes
Message-ID: <1350776094-16778-1-git-send-email-michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unneeded includes. These are leftovers from platform device
registrations.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm/mach-kirkwood/board-lsxl.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-lsxl.c b/arch/arm/mach-kirkwood/board-lsxl.c
index 83d8975..64e5cc6 100644
--- a/arch/arm/mach-kirkwood/board-lsxl.c
+++ b/arch/arm/mach-kirkwood/board-lsxl.c
@@ -14,17 +14,9 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/mtd/partitions.h>
-#include <linux/ata_platform.h>
-#include <linux/spi/flash.h>
-#include <linux/spi/spi.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/gpio.h>
 #include <linux/gpio-fan.h>
-#include <linux/input.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <mach/kirkwood.h>
 #include "common.h"
 #include "mpp.h"
 
-- 
1.7.2.5
