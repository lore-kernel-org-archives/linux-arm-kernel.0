From: robherring2@gmail.com (Rob Herring)
Date: Thu, 13 Sep 2012 08:07:23 -0500
Subject: [PATCH] staging: ste_rmi4: remove gpio.h include
In-Reply-To: <1346960563-18689-1-git-send-email-robherring2@gmail.com>
References: <1346960563-18689-1-git-send-email-robherring2@gmail.com>
Message-ID: <1347541643-30665-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

gpio.h is not needed and is going to be removed.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---

Here's one more trivial fix in preparation of mach/gpio.h removal. I plan
to take this thru arm-soc tree.

Rob

 .../staging/ste_rmi4/board-mop500-u8500uib-rmi4.c  |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/ste_rmi4/board-mop500-u8500uib-rmi4.c b/drivers/staging/ste_rmi4/board-mop500-u8500uib-rmi4.c
index a272e48..47439c3 100644
--- a/drivers/staging/ste_rmi4/board-mop500-u8500uib-rmi4.c
+++ b/drivers/staging/ste_rmi4/board-mop500-u8500uib-rmi4.c
@@ -5,7 +5,6 @@
 #include <linux/i2c.h>
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
-#include <mach/gpio.h>
 #include <mach/irqs.h>
 #include "synaptics_i2c_rmi4.h"
 
-- 
1.7.9.5
