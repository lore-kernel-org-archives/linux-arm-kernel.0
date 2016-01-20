From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 20 Jan 2016 19:27:22 +0800
Subject: [PATCH v3 1/4] net: mvneta: sort the headers in alphabetic order
In-Reply-To: <1453289245-2061-1-git-send-email-jszhang@marvell.com>
References: <1453289245-2061-1-git-send-email-jszhang@marvell.com>
Message-ID: <1453289245-2061-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorting the headers in alphabetic order will help to reduce the conflict
when adding new headers in the future.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index fabc8df..8e85a53 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -11,28 +11,28 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/kernel.h>
-#include <linux/netdevice.h>
+#include <linux/clk.h>
+#include <linux/cpu.h>
 #include <linux/etherdevice.h>
-#include <linux/platform_device.h>
-#include <linux/skbuff.h>
+#include <linux/if_vlan.h>
 #include <linux/inetdevice.h>
-#include <linux/mbus.h>
-#include <linux/module.h>
 #include <linux/interrupt.h>
-#include <linux/if_vlan.h>
-#include <net/ip.h>
-#include <net/ipv6.h>
 #include <linux/io.h>
-#include <net/tso.h>
+#include <linux/kernel.h>
+#include <linux/mbus.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
-#include <linux/of_address.h>
 #include <linux/phy.h>
-#include <linux/clk.h>
-#include <linux/cpu.h>
+#include <linux/platform_device.h>
+#include <linux/skbuff.h>
+#include <net/ip.h>
+#include <net/ipv6.h>
+#include <net/tso.h>
 
 /* Registers */
 #define MVNETA_RXQ_CONFIG_REG(q)                (0x1400 + ((q) << 2))
-- 
2.7.0.rc3
