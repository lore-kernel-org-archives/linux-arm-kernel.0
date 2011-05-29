From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 29 May 2011 10:01:48 +0200
Subject: [PATCH] at91_udc: include linux/prefetch.h explicitly
Message-ID: <1306656108-21992-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/gadget/at91_udc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index 41dc093..8e750e3 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -35,6 +35,7 @@
 #include <linux/list.h>
 #include <linux/interrupt.h>
 #include <linux/proc_fs.h>
+#include <linux/prefetch.h>
 #include <linux/clk.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
-- 
1.7.4.1
