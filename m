From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 19 Aug 2016 20:37:45 +0800
Subject: [PATCH v2] usb: chipidea: delete an useless header include
Message-ID: <20160819123745.837-1-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<linux/phy.h> is for net phy drivers, we don't need it.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---

Since v1:
  - fix commit subject. Thank Sergei for pointing it out.

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
