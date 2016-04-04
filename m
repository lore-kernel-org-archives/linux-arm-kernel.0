From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Mon,  4 Apr 2016 15:48:34 -0400
Subject: [PATCH] arm: lpc32xx: remove reboot header file
Message-ID: <1459799314-8987-1-git-send-email-slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylvain Lemieux <slemieux@tycoint.com>

The header file "reboot.h" is no longer needed, following
the migration of the restart code into the pnx4008 watchdog.

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
 arch/arm/mach-lpc32xx/common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-lpc32xx/common.h b/arch/arm/mach-lpc32xx/common.h
index 2d90801..9b5ae42 100644
--- a/arch/arm/mach-lpc32xx/common.h
+++ b/arch/arm/mach-lpc32xx/common.h
@@ -21,7 +21,6 @@
 
 #include <mach/board.h>
 #include <linux/platform_device.h>
-#include <linux/reboot.h>
 
 /*
  * Other arch specific structures and functions
-- 
1.8.3.1
