From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 20 Oct 2012 12:42:14 +0200
Subject: [PATCH 1/3] ARM: Kirkwood: Remove unused includes
Message-ID: <1350729736-14539-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the gradual conversion of C code to DT, there are a number of
include files which are no longer needed. Remove them.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-kirkwood/board-dockstar.c       |   13 -------------
 arch/arm/mach-kirkwood/board-dreamplug.c      |   15 ---------------
 arch/arm/mach-kirkwood/board-goflexnet.c      |   13 -------------
 arch/arm/mach-kirkwood/board-ib62x0.c         |    6 ------
 arch/arm/mach-kirkwood/board-iconnect.c       |    8 --------
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c |    2 --
 arch/arm/mach-kirkwood/board-lsxl.c           |    8 --------
 arch/arm/mach-kirkwood/board-ts219.c          |    3 ---
 8 files changed, 68 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dockstar.c b/arch/arm/mach-kirkwood/board-dockstar.c
index f2fbb02..6912882 100644
--- a/arch/arm/mach-kirkwood/board-dockstar.c
+++ b/arch/arm/mach-kirkwood/board-dockstar.c
@@ -16,21 +16,8 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/ata_platform.h>
 #include <linux/mv643xx_eth.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_fdt.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/gpio.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <mach/kirkwood.h>
-#include <mach/bridge-regs.h>
-#include <linux/platform_data/mmc-mvsdio.h>
 #include "common.h"
 #include "mpp.h"
 
diff --git a/arch/arm/mach-kirkwood/board-dreamplug.c b/arch/arm/mach-kirkwood/board-dreamplug.c
index 20af53a..8a8ebe0 100644
--- a/arch/arm/mach-kirkwood/board-dreamplug.c
+++ b/arch/arm/mach-kirkwood/board-dreamplug.c
@@ -13,23 +13,8 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/ata_platform.h>
 #include <linux/mv643xx_eth.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_fdt.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/gpio.h>
-#include <linux/mtd/physmap.h>
-#include <linux/spi/flash.h>
-#include <linux/spi/spi.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <mach/kirkwood.h>
-#include <mach/bridge-regs.h>
 #include <linux/platform_data/mmc-mvsdio.h>
 #include "common.h"
 #include "mpp.h"
diff --git a/arch/arm/mach-kirkwood/board-goflexnet.c b/arch/arm/mach-kirkwood/board-goflexnet.c
index 001ca8c..5dcd0d6 100644
--- a/arch/arm/mach-kirkwood/board-goflexnet.c
+++ b/arch/arm/mach-kirkwood/board-goflexnet.c
@@ -18,21 +18,8 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/ata_platform.h>
 #include <linux/mv643xx_eth.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_fdt.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/gpio.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <mach/kirkwood.h>
-#include <mach/bridge-regs.h>
-#include <linux/platform_data/mmc-mvsdio.h>
 #include "common.h"
 #include "mpp.h"
 
diff --git a/arch/arm/mach-kirkwood/board-ib62x0.c b/arch/arm/mach-kirkwood/board-ib62x0.c
index cfc47f8..6d3a564 100644
--- a/arch/arm/mach-kirkwood/board-ib62x0.c
+++ b/arch/arm/mach-kirkwood/board-ib62x0.c
@@ -13,15 +13,9 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/mtd/partitions.h>
-#include <linux/ata_platform.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/gpio.h>
 #include <linux/input.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <mach/kirkwood.h>
 #include "common.h"
 #include "mpp.h"
 
diff --git a/arch/arm/mach-kirkwood/board-iconnect.c b/arch/arm/mach-kirkwood/board-iconnect.c
index d084b1e..24f5aa7 100644
--- a/arch/arm/mach-kirkwood/board-iconnect.c
+++ b/arch/arm/mach-kirkwood/board-iconnect.c
@@ -10,16 +10,8 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_fdt.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/mv643xx_eth.h>
-#include <linux/gpio.h>
-#include <asm/mach/arch.h>
-#include <mach/kirkwood.h>
 #include "common.h"
 #include "mpp.h"
 
diff --git a/arch/arm/mach-kirkwood/board-iomega_ix2_200.c b/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
index 158fb97..e4ed62c 100644
--- a/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
+++ b/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
@@ -10,10 +10,8 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/platform_device.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/ethtool.h>
-#include <mach/kirkwood.h>
 #include "common.h"
 #include "mpp.h"
 
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
 
diff --git a/arch/arm/mach-kirkwood/board-ts219.c b/arch/arm/mach-kirkwood/board-ts219.c
index 1750e68..f3bfeda 100644
--- a/arch/arm/mach-kirkwood/board-ts219.c
+++ b/arch/arm/mach-kirkwood/board-ts219.c
@@ -19,9 +19,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/mv643xx_eth.h>
-#include <linux/ata_platform.h>
-#include <linux/gpio_keys.h>
-#include <linux/input.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
-- 
1.7.10.4
