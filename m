From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Aug 2012 17:31:29 -0500
Subject: [PATCH 03/10] serial: atmel: add explict mach/gpio.h include
In-Reply-To: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
References: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346279496-26286-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In preparation to remove implicit inclusion of mach/gpio.h, add explicit
include of mach/gpio.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Alan Cox <alan@linux.intel.com>
---
 drivers/tty/serial/atmel_serial.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 3d7e1ee..c799001 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -48,7 +48,7 @@
 
 #ifdef CONFIG_ARM
 #include <mach/cpu.h>
-#include <asm/gpio.h>
+#include <mach/gpio.h>
 #endif
 
 #define PDC_BUFFER_SIZE		512
-- 
1.7.9.5
