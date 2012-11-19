From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 12:00:32 +0100
Subject: [PATCH 1/3] net: mvmdio: use <linux/delay.h> instead of <asm/delay.h>
In-Reply-To: <1353322834-16952-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353322834-16952-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353322834-16952-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As suggested by checkpatch, using <linux/delay.h> instead of
<asm/delay.h> is appropriate.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvmdio.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 82fbd23..114a0f1 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -27,8 +27,7 @@
 #include <linux/of_address.h>
 #include <linux/of_mdio.h>
 #include <linux/platform_device.h>
-
-#include <asm/delay.h>
+#include <linux/delay.h>
 
 #define MVMDIO_SMI_DATA_SHIFT              0
 #define MVMDIO_SMI_PHY_ADDR_SHIFT          16
-- 
1.7.9.5
