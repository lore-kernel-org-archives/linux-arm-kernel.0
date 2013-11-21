From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Nov 2013 16:06:30 +0100
Subject: [PATCH] ARM: mv78xx0: delete local <mach/gpio.h> header
Message-ID: <1385046390-13499-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This header is not used by anything, and since the arch does
not specify NEED_MACH_GPIO_H it is not included into
<linux/gpio.h> either. Delete it.

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I'm seeking an ACK from one of the mv78xx0 maintainers to
take this through the GPIO tree.
---
 arch/arm/mach-mv78xx0/include/mach/gpio.h | 9 ---------
 1 file changed, 9 deletions(-)
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/gpio.h

diff --git a/arch/arm/mach-mv78xx0/include/mach/gpio.h b/arch/arm/mach-mv78xx0/include/mach/gpio.h
deleted file mode 100644
index 77e1b843e768..000000000000
--- a/arch/arm/mach-mv78xx0/include/mach/gpio.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/*
- * arch/asm-arm/mach-mv78xx0/include/mach/gpio.h
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <plat/gpio.h>
-- 
1.8.3.1
