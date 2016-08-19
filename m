From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 19 Aug 2016 20:05:44 +0800
Subject: [PATCH] usb: chipidea: delete an useless header file
Message-ID: <20160819120544.651-1-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<linux/phy.h> is for net phy drivers, we don't need it.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/usb/chipidea/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 69426e6..ae12595 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -62,7 +62,6 @@
 #include <linux/usb/chipidea.h>
 #include <linux/usb/of.h>
 #include <linux/of.h>
-#include <linux/phy.h>
 #include <linux/regulator/consumer.h>
 #include <linux/usb/ehci_def.h>
 
-- 
2.9.3
