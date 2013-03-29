From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 Mar 2013 16:55:40 +0800
Subject: [PATCH 04/13] ARM: mxs: remove empty hardware.h
In-Reply-To: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
References: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364547350-30498-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hardware.h is an empty header and used nowhere now.  Remmove it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/include/mach/hardware.h |   23 -----------------------
 arch/arm/mach-mxs/include/mach/mxs.h      |    1 -
 2 files changed, 24 deletions(-)
 delete mode 100644 arch/arm/mach-mxs/include/mach/hardware.h

diff --git a/arch/arm/mach-mxs/include/mach/hardware.h b/arch/arm/mach-mxs/include/mach/hardware.h
deleted file mode 100644
index 4c0e8a6..0000000
--- a/arch/arm/mach-mxs/include/mach/hardware.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA  02110-1301, USA.
- */
-
-#ifndef __MACH_MXS_HARDWARE_H__
-#define __MACH_MXS_HARDWARE_H__
-
-#endif /* __MACH_MXS_HARDWARE_H__ */
diff --git a/arch/arm/mach-mxs/include/mach/mxs.h b/arch/arm/mach-mxs/include/mach/mxs.h
index a9be80a..5820b04 100644
--- a/arch/arm/mach-mxs/include/mach/mxs.h
+++ b/arch/arm/mach-mxs/include/mach/mxs.h
@@ -23,7 +23,6 @@
 #include <linux/io.h>
 #endif
 #include <mach/digctl.h>
-#include <mach/hardware.h>
 
 /*
  * IO addresses common to MXS-based
-- 
1.7.9.5
