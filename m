From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  1 Dec 2015 00:00:58 +0100
Subject: [PATCH 7/7] ARM: netx: remove unused mach/param.h
In-Reply-To: <1448924458-3279040-1-git-send-email-arnd@arndb.de>
References: <1448924458-3279040-1-git-send-email-arnd@arndb.de>
Message-ID: <1448924458-3279040-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I could not find any users of this file, past or present, and
it contains only a comment, so let's remove it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-netx/include/mach/param.h | 18 ------------------
 1 file changed, 18 deletions(-)
 delete mode 100644 arch/arm/mach-netx/include/mach/param.h

diff --git a/arch/arm/mach-netx/include/mach/param.h b/arch/arm/mach-netx/include/mach/param.h
deleted file mode 100644
index a771459206aa..000000000000
--- a/arch/arm/mach-netx/include/mach/param.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- *  arch/arm/mach-netx/include/mach/param.h
- *
- * Copyright (C) 2005 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2
- * as published by the Free Software Foundation.
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
-- 
2.1.0.rc2
