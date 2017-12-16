From: pravin.shedge4linux@gmail.com (Pravin Shedge)
Date: Sat, 16 Dec 2017 18:26:52 +0530
Subject: [PATCH] drivers: gpio: remove duplicate includes
Message-ID: <1513429012-8327-1-git-send-email-pravin.shedge4linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These duplicate includes have been found with scripts/checkincludes.pl
but they have been removed manually to avoid removing false positives.

Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
---
 drivers/gpio/gpio-brcmstb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 545d43a..3dcbead 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -19,7 +19,6 @@
 #include <linux/irqdomain.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/interrupt.h>
-#include <linux/bitops.h>
 
 enum gio_reg_index {
 	GIO_REG_ODEN = 0,
-- 
2.7.4
