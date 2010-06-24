From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:02 +0200
Subject: [PATCH 06/61] ARM: imx: remove empty and unused board headers
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-7-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx2/mach-imx27lite.c                 |    1 -
 arch/arm/mach-mx3/mach-armadillo5x0.c              |    1 -
 arch/arm/mach-mx3/mach-pcm037.c                    |    1 -
 .../arm/plat-mxc/include/mach/board-armadillo5x0.h |   15 -------------
 arch/arm/plat-mxc/include/mach/board-mx27lite.h    |   14 ------------
 arch/arm/plat-mxc/include/mach/board-mx35pdk.h     |   22 --------------------
 arch/arm/plat-mxc/include/mach/board-pcm037.h      |   22 --------------------
 arch/arm/plat-mxc/include/mach/board-pcm043.h      |   22 --------------------
 8 files changed, 0 insertions(+), 98 deletions(-)
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-armadillo5x0.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx27lite.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx35pdk.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-pcm037.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-pcm043.h

diff --git a/arch/arm/mach-mx2/mach-imx27lite.c b/arch/arm/mach-mx2/mach-imx27lite.c
index b5710bf..fd1dddb 100644
--- a/arch/arm/mach-mx2/mach-imx27lite.c
+++ b/arch/arm/mach-mx2/mach-imx27lite.c
@@ -28,7 +28,6 @@
 #include <mach/common.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx27.h>
-#include <mach/board-mx27lite.h>
 
 #include "devices.h"
 
diff --git a/arch/arm/mach-mx3/mach-armadillo5x0.c b/arch/arm/mach-mx3/mach-armadillo5x0.c
index 5f72ec9..2a8de89 100644
--- a/arch/arm/mach-mx3/mach-armadillo5x0.c
+++ b/arch/arm/mach-mx3/mach-armadillo5x0.c
@@ -50,7 +50,6 @@
 #include <mach/common.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
-#include <mach/board-armadillo5x0.h>
 #include <mach/mmc.h>
 #include <mach/ipu.h>
 #include <mach/mx3fb.h>
diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
index cce4106..8419370 100644
--- a/arch/arm/mach-mx3/mach-pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -43,7 +43,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
-#include <mach/board-pcm037.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/i2c.h>
diff --git a/arch/arm/plat-mxc/include/mach/board-armadillo5x0.h b/arch/arm/plat-mxc/include/mach/board-armadillo5x0.h
deleted file mode 100644
index 0376c13..0000000
--- a/arch/arm/plat-mxc/include/mach/board-armadillo5x0.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * Copyright 2009 Alberto Panizzo <maramaopercheseimorto@gmail.com>.
- * All Rights Reserved.
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_MXC_BOARD_ARMADILLO5X0_H__
-#define __ASM_ARCH_MXC_BOARD_ARMADILLO5X0_H__
-
-#endif
diff --git a/arch/arm/plat-mxc/include/mach/board-mx27lite.h b/arch/arm/plat-mxc/include/mach/board-mx27lite.h
deleted file mode 100644
index ea87551..0000000
--- a/arch/arm/plat-mxc/include/mach/board-mx27lite.h
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
-#ifndef __ASM_ARCH_MXC_BOARD_MX27LITE_H__
-#define __ASM_ARCH_MXC_BOARD_MX27LITE_H__
-
-#endif /* __ASM_ARCH_MXC_BOARD_MX27LITE_H__ */
diff --git a/arch/arm/plat-mxc/include/mach/board-mx35pdk.h b/arch/arm/plat-mxc/include/mach/board-mx35pdk.h
deleted file mode 100644
index 383f1c0..0000000
--- a/arch/arm/plat-mxc/include/mach/board-mx35pdk.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- *  Copyright 2009 Freescale Semiconductor, Inc. All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#ifndef __ASM_ARCH_MXC_BOARD_MX35PDK_H__
-#define __ASM_ARCH_MXC_BOARD_MX35PDK_H__
-
-#endif /* __ASM_ARCH_MXC_BOARD_MX35PDK_H__ */
diff --git a/arch/arm/plat-mxc/include/mach/board-pcm037.h b/arch/arm/plat-mxc/include/mach/board-pcm037.h
deleted file mode 100644
index 1341170..0000000
--- a/arch/arm/plat-mxc/include/mach/board-pcm037.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- *  Copyright (C) 2008 Sascha Hauer, Pengutronix
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#ifndef __ASM_ARCH_MXC_BOARD_PCM037_H__
-#define __ASM_ARCH_MXC_BOARD_PCM037_H__
-
-#endif /* __ASM_ARCH_MXC_BOARD_PCM037_H__ */
diff --git a/arch/arm/plat-mxc/include/mach/board-pcm043.h b/arch/arm/plat-mxc/include/mach/board-pcm043.h
deleted file mode 100644
index 1ac4e16..0000000
--- a/arch/arm/plat-mxc/include/mach/board-pcm043.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- *  Copyright (C) 2008 Sascha Hauer, Pengutronix
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#ifndef __ASM_ARCH_MXC_BOARD_PCM043_H__
-#define __ASM_ARCH_MXC_BOARD_PCM043_H__
-
-#endif /* __ASM_ARCH_MXC_BOARD_PCM043_H__ */
-- 
1.7.1
