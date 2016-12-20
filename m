From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 20 Dec 2016 17:24:23 -0500
Subject: [PATCH 2/2] soc: ti: knav: cleanup includes and sort header files
In-Reply-To: <1482272663-29829-1-git-send-email-m-karicheri2@ti.com>
References: <1482272663-29829-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1482272663-29829-2-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch cleanup the code to remove unnecessary header files and
also sort the header files.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/soc/ti/knav_qmss_acc.c   | 15 +++------------
 drivers/soc/ti/knav_qmss_queue.c | 25 ++++++++-----------------
 2 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_acc.c b/drivers/soc/ti/knav_qmss_acc.c
index 0612eba..3d7225f 100644
--- a/drivers/soc/ti/knav_qmss_acc.c
+++ b/drivers/soc/ti/knav_qmss_acc.c
@@ -16,21 +16,12 @@
  * General Public License for more details.
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
-#include <linux/bitops.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/soc/ti/knav_qmss.h>
-#include <linux/platform_device.h>
-#include <linux/dma-mapping.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
-#include <linux/firmware.h>
+#include <linux/soc/ti/knav_qmss.h>
 
 #include "knav_qmss.h"
 
diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index eacad57..279e7c5 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -16,26 +16,17 @@
  * General Public License for more details.
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/interrupt.h>
-#include <linux/bitops.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/platform_device.h>
+#include <linux/debugfs.h>
 #include <linux/dma-mapping.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
-#include <linux/of_device.h>
+#include <linux/firmware.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/pm_runtime.h>
-#include <linux/firmware.h>
-#include <linux/debugfs.h>
-#include <linux/seq_file.h>
-#include <linux/string.h>
+#include <linux/slab.h>
 #include <linux/soc/ti/knav_qmss.h>
 
 #include "knav_qmss.h"
-- 
1.9.1
