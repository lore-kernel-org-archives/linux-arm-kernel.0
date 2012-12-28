From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Dec 2012 13:32:57 +0100
Subject: [PATCH] ARM: Kirkwood: Cleanup unneeded include files
Message-ID: <1356697977-4105-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove include files which are no longer needed after converting
to device tree.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-kirkwood/board-ib62x0.c  |    1 -
 arch/arm/mach-kirkwood/board-mplcec4.c |    1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-ib62x0.c b/arch/arm/mach-kirkwood/board-ib62x0.c
index 9f6f496..9a857ae 100644
--- a/arch/arm/mach-kirkwood/board-ib62x0.c
+++ b/arch/arm/mach-kirkwood/board-ib62x0.c
@@ -14,7 +14,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/mv643xx_eth.h>
-#include <linux/input.h>
 #include "common.h"
 
 static struct mv643xx_eth_platform_data ib62x0_ge00_data = {
diff --git a/arch/arm/mach-kirkwood/board-mplcec4.c b/arch/arm/mach-kirkwood/board-mplcec4.c
index 56bfe5a..3264925 100644
--- a/arch/arm/mach-kirkwood/board-mplcec4.c
+++ b/arch/arm/mach-kirkwood/board-mplcec4.c
@@ -14,7 +14,6 @@
 #include <linux/mv643xx_eth.h>
 #include <linux/platform_data/mmc-mvsdio.h>
 #include "common.h"
-#include "mpp.h"
 
 static struct mv643xx_eth_platform_data mplcec4_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(1),
-- 
1.7.10.4
