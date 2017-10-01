From: jonas.gorski@gmail.com (Jonas Gorski)
Date: Sun,  1 Oct 2017 13:02:20 +0200
Subject: [PATCH 6/6] bcm63xx_enet: remove unneeded include
In-Reply-To: <20171001110220.27668-1-jonas.gorski@gmail.com>
References: <20171001110220.27668-1-jonas.gorski@gmail.com>
Message-ID: <20171001110220.27668-7-jonas.gorski@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't use anyhing from that file, so drop it.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm63xx_enet.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.h b/drivers/net/ethernet/broadcom/bcm63xx_enet.h
index 0a1b7b2e55bd..dd6ae3077433 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.h
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.h
@@ -8,7 +8,6 @@
 #include <linux/platform_device.h>
 
 #include <bcm63xx_regs.h>
-#include <bcm63xx_irq.h>
 #include <bcm63xx_io.h>
 #include <bcm63xx_iudma.h>
 
-- 
2.13.2
