From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu,  8 Jun 2017 11:26:47 +0200
Subject: [PATCH v2 2/8] net: mvmdio: use tabs for defines
In-Reply-To: <20170608092653.25221-1-antoine.tenart@free-electrons.com>
References: <20170608092653.25221-1-antoine.tenart@free-electrons.com>
Message-ID: <20170608092653.25221-3-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cosmetic patch replacing spaces by tabs for defined values.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/marvell/mvmdio.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 109a2bff334d..17b518b13ae3 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -30,25 +30,25 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 
-#define MVMDIO_SMI_DATA_SHIFT              0
-#define MVMDIO_SMI_PHY_ADDR_SHIFT          16
-#define MVMDIO_SMI_PHY_REG_SHIFT           21
-#define MVMDIO_SMI_READ_OPERATION          BIT(26)
-#define MVMDIO_SMI_WRITE_OPERATION         0
-#define MVMDIO_SMI_READ_VALID              BIT(27)
-#define MVMDIO_SMI_BUSY                    BIT(28)
-#define MVMDIO_ERR_INT_CAUSE		   0x007C
-#define  MVMDIO_ERR_INT_SMI_DONE	   0x00000010
-#define MVMDIO_ERR_INT_MASK		   0x0080
+#define MVMDIO_SMI_DATA_SHIFT		0
+#define MVMDIO_SMI_PHY_ADDR_SHIFT	16
+#define MVMDIO_SMI_PHY_REG_SHIFT	21
+#define MVMDIO_SMI_READ_OPERATION	BIT(26)
+#define MVMDIO_SMI_WRITE_OPERATION	0
+#define MVMDIO_SMI_READ_VALID		BIT(27)
+#define MVMDIO_SMI_BUSY			BIT(28)
+#define MVMDIO_ERR_INT_CAUSE		0x007C
+#define  MVMDIO_ERR_INT_SMI_DONE	0x00000010
+#define MVMDIO_ERR_INT_MASK		0x0080
 
 /*
  * SMI Timeout measurements:
  * - Kirkwood 88F6281 (Globalscale Dreamplug): 45us to 95us (Interrupt)
  * - Armada 370       (Globalscale Mirabox):   41us to 43us (Polled)
  */
-#define MVMDIO_SMI_TIMEOUT		   1000 /* 1000us = 1ms */
-#define MVMDIO_SMI_POLL_INTERVAL_MIN	   45
-#define MVMDIO_SMI_POLL_INTERVAL_MAX	   55
+#define MVMDIO_SMI_TIMEOUT		1000 /* 1000us = 1ms */
+#define MVMDIO_SMI_POLL_INTERVAL_MIN	45
+#define MVMDIO_SMI_POLL_INTERVAL_MAX	55
 
 struct orion_mdio_dev {
 	struct mutex lock;
-- 
2.9.4
