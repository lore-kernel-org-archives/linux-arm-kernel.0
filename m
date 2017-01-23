From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 23 Jan 2017 15:05:45 +0800
Subject: [RESEND PATCH] usb: chipidea: delete an useless header include
Message-ID: <20170123070545.2714-1-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<linux/phy.h> is for net phy drivers, we don't need it.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/usb/chipidea/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 3dbb4a21ab44..77078083e9fb 100644
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
2.11.0
