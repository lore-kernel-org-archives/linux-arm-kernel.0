From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 12 Jan 2015 19:42:10 +0100
Subject: [PATCH 1/7] ARM: at91: remove unused mach/memory.h
In-Reply-To: <1421088136-10172-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421088136-10172-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1421088136-10172-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_NEED_MACH_MEMORY_H is not set by any at91 platform, remove mach/memory.h

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/include/mach/memory.h | 26 --------------------------
 1 file changed, 26 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/memory.h

diff --git a/arch/arm/mach-at91/include/mach/memory.h b/arch/arm/mach-at91/include/mach/memory.h
deleted file mode 100644
index 401c207f2f39..000000000000
--- a/arch/arm/mach-at91/include/mach/memory.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * arch/arm/mach-at91/include/mach/memory.h
- *
- *  Copyright (C) 2004 SAN People
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
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-#include <mach/hardware.h>
-
-#endif
-- 
2.1.0
