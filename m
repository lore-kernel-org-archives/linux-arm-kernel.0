From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 17:54:41 +0900
Subject: [PATCH 11/16] ARM: shmobile: r8a7779: camera-rcar header cleanup
In-Reply-To: <cover.1385628709.git.horms+renesas@verge.net.au>
References: <cover.1385628709.git.horms+renesas@verge.net.au>
Message-ID: <2f3927e815e82874af76db51f8d2c2a596bc6cee.1385628709.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

<linux/platform_data/camera-rcar.h> is needed on Marzen,
not setup-r8a7779.c

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen.c         | 1 +
 arch/arm/mach-shmobile/include/mach/r8a7779.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index fa102f7..4f9e3ec 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -29,6 +29,7 @@
 #include <linux/leds.h>
 #include <linux/dma-mapping.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/platform_data/camera-rcar.h>
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_data/rcar-du.h>
 #include <linux/platform_data/usb-rcar-phy.h>
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index 905420a..1cab247 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -4,7 +4,6 @@
 #include <linux/sh_clk.h>
 #include <linux/pm_domain.h>
 #include <linux/sh_eth.h>
-#include <linux/platform_data/camera-rcar.h>
 
 /* HPB-DMA slave IDs */
 enum {
-- 
1.8.4
