From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Tue, 9 Aug 2016 15:04:41 +0530
Subject: [RFC PATCH v5 1/3] net: Add mask for Control register 10Mbps speed
In-Reply-To: <1470735283-23611-1-git-send-email-appanad@xilinx.com>
References: <1470735283-23611-1-git-send-email-appanad@xilinx.com>
Message-ID: <1470735283-23611-2-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds mask for the Control register
10Mbps speed.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v5:
---> New patch as suggested by Punnaiah.

 include/uapi/linux/mii.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/mii.h b/include/uapi/linux/mii.h
index 237fac4..15d8510 100644
--- a/include/uapi/linux/mii.h
+++ b/include/uapi/linux/mii.h
@@ -48,6 +48,7 @@
 #define BMCR_SPEED100		0x2000	/* Select 100Mbps              */
 #define BMCR_LOOPBACK		0x4000	/* TXD loopback bits           */
 #define BMCR_RESET		0x8000	/* Reset to default state      */
+#define BMCR_SPEED10		0x0000	/* Select 10Mbps               */
 
 /* Basic mode status register. */
 #define BMSR_ERCAP		0x0001	/* Ext-reg capability          */
-- 
2.1.2
