From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 15 Jun 2017 16:43:16 +0200
Subject: [PATCH net-next v5 01/11] net: mvmdio: reorder headers alphabetically
In-Reply-To: <20170615144326.24463-1-antoine.tenart@free-electrons.com>
References: <20170615144326.24463-1-antoine.tenart@free-electrons.com>
Message-ID: <20170615144326.24463-2-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cosmetic fix reordering headers alphabetically.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/marvell/mvmdio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 90a60b98c28e..109a2bff334d 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -17,16 +17,16 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of_mdio.h>
 #include <linux/phy.h>
-#include <linux/interrupt.h>
 #include <linux/platform_device.h>
-#include <linux/delay.h>
-#include <linux/io.h>
-#include <linux/clk.h>
-#include <linux/of_mdio.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
 
-- 
2.9.4
