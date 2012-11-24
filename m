From: cesarb@cesarb.net (Cesar Eduardo Barros)
Date: Fri, 23 Nov 2012 22:26:26 -0200
Subject: [PATCH 02/24] MAINTAINERS: remove arch/arm/common/time-acorn.c
In-Reply-To: <1353716808-16375-1-git-send-email-cesarb@cesarb.net>
References: <1353716808-16375-1-git-send-email-cesarb@cesarb.net>
Message-ID: <1353716808-16375-3-git-send-email-cesarb@cesarb.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This file was moved to arch/arm/mach-rpc/time.c by commit a1be5d6 (ARM:
riscpc: move time-acorn.c to mach-rpc), and the pattern for
arch/arm/mach-rpc/ already exists.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.net>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c2fc7af..041872a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1050,7 +1050,6 @@ M:	Russell King <linux@arm.linux.org.uk>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 W:	http://www.arm.linux.org.uk/
 S:	Maintained
-F:	arch/arm/common/time-acorn.c
 F:	arch/arm/include/asm/hardware/entry-macro-iomd.S
 F:	arch/arm/include/asm/hardware/ioc.h
 F:	arch/arm/include/asm/hardware/iomd.h
-- 
1.7.11.7
