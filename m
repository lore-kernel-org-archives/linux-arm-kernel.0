From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 15:06:56 +0900
Subject: [PATCH 04/13] ARM: shmobile: r8a7778: camera-rcar header cleanup
In-Reply-To: <cover.1387857168.git.horms+renesas@verge.net.au>
References: <cover.1387857168.git.horms+renesas@verge.net.au>
Message-ID: <02d39132e75410633c637be006b9b772a6116da3.1387857168.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

<linux/platform_data/camera-rcar.h> is needed on BockW,
not setup-r8a7778.c

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c          | 1 +
 arch/arm/mach-shmobile/include/mach/r8a7778.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 3861152..44b55ef 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -25,6 +25,7 @@
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mtd/partitions.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/platform_data/camera-rcar.h>
 #include <linux/platform_data/usb-rcar-phy.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/fixed.h>
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index a3440e5..72c9d37 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -20,7 +20,6 @@
 #define __ASM_R8A7778_H__
 
 #include <linux/sh_eth.h>
-#include <linux/platform_data/camera-rcar.h>
 
 /* HPB-DMA slave IDs */
 enum {
-- 
1.8.4
