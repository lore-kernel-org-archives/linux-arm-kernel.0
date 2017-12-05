From: pravin.shedge4linux@gmail.com (Pravin Shedge)
Date: Tue,  5 Dec 2017 07:28:24 +0530
Subject: [PATCH 03/45] drivers: gpio: remove duplicate includes
Message-ID: <1512439104-15507-1-git-send-email-pravin.shedge4linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These duplicate includes have been found with scripts/checkincludes.pl but
they have been removed manually to avoid removing false positives.

Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
---
 drivers/gpio/gpio-brcmstb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 545d43a..f40ec39 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -11,7 +11,6 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/bitops.h>
 #include <linux/gpio/driver.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
-- 
2.7.4
