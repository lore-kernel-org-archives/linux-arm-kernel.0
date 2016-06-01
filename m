From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed,  1 Jun 2016 22:07:31 +0300
Subject: [PATCH 1/2] ARM: imx: Remove orphan header
Message-ID: <1464808052-3855-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The header eukrea-baseboards.h is not used, remove it.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/eukrea-baseboards.h | 42 -----------------------------------
 1 file changed, 42 deletions(-)
 delete mode 100644 arch/arm/mach-imx/eukrea-baseboards.h

diff --git a/arch/arm/mach-imx/eukrea-baseboards.h b/arch/arm/mach-imx/eukrea-baseboards.h
deleted file mode 100644
index bb2c90d..0000000
--- a/arch/arm/mach-imx/eukrea-baseboards.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- * Copyright (C) 2010 Eric Benard - eric at eukrea.com
- *
- * Based on board-pcm038.h which is :
- * Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
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
- * MA 02110-1301, USA.
- */
-
-#ifndef __MACH_EUKREA_BASEBOARDS_H__
-#define __MACH_EUKREA_BASEBOARDS_H__
-
-#ifndef __ASSEMBLY__
-/*
- * This CPU module needs a baseboard to work. After basic initializing
- * its own devices, it calls baseboard's init function.
- * TODO: Add your own baseboard init function and call it from
- * inside eukrea_cpuimx25_init() or eukrea_cpuimx35_init()
- *
- * This example here is for the development board. Refer
- * mach-mx25/eukrea_mbimxsd-baseboard.c for cpuimx25
- * mach-mx3/eukrea_mbimxsd-baseboard.c for cpuimx35
- */
-
-extern void eukrea_mbimxsd25_baseboard_init(void);
-extern void eukrea_mbimxsd35_baseboard_init(void);
-
-#endif
-
-#endif /* __MACH_EUKREA_BASEBOARDS_H__ */
-- 
2.4.9
