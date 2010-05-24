From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 24 May 2010 21:55:42 +0200
Subject: [PATCH 07/16] arm/mx2/mx27_3ds: document alternative names and remove
	empty header
In-Reply-To: <20100524195430.GA28403@pengutronix.de>
References: <20100524195430.GA28403@pengutronix.de>
Message-ID: <1274730951-29106-7-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx2/mach-mx27_3ds.c              |    7 ++++++-
 arch/arm/plat-mxc/include/mach/board-mx27pdk.h |   14 --------------
 2 files changed, 6 insertions(+), 15 deletions(-)
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx27pdk.h

diff --git a/arch/arm/mach-mx2/mach-mx27_3ds.c b/arch/arm/mach-mx2/mach-mx27_3ds.c
index b2f4e0d..a45df59 100644
--- a/arch/arm/mach-mx2/mach-mx27_3ds.c
+++ b/arch/arm/mach-mx2/mach-mx27_3ds.c
@@ -18,6 +18,12 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+/*
+ * This machine is known as:
+ *  - i.MX27 3-Stack Development System
+ *  - i.MX27 Platform Development Kit (i.MX27 PDK)
+ */
+
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <asm/mach-types.h>
@@ -27,7 +33,6 @@
 #include <mach/common.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx27.h>
-#include <mach/board-mx27pdk.h>
 
 #include "devices.h"
 
diff --git a/arch/arm/plat-mxc/include/mach/board-mx27pdk.h b/arch/arm/plat-mxc/include/mach/board-mx27pdk.h
deleted file mode 100644
index fec1bcf..0000000
--- a/arch/arm/plat-mxc/include/mach/board-mx27pdk.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * Copyright 2009 Freescale Semiconductor, Inc. All Rights Reserved.
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_MXC_BOARD_MX27PDK_H__
-#define __ASM_ARCH_MXC_BOARD_MX27PDK_H__
-
-#endif /* __ASM_ARCH_MXC_BOARD_MX27PDK_H__ */
-- 
1.7.0
