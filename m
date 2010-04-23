From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Apr 2010 16:12:03 -0700
Subject: [PATCH 25/28] omap: Devkit8000: Remove unnecessary include file
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Message-ID: <20100423231203.31953.19329.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Weber <weber@corscience.de>

Remove include otg.h.

Signed-off-by: Thomas Weber <weber@corscience.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-devkit8000.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 3fafef4..d605e05 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -50,7 +50,6 @@
 #include <linux/input/matrix_keypad.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
-#include <linux/usb/otg.h>
 #include <linux/dm9000.h>
 #include <linux/interrupt.h>
 
