From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 21 Dec 2016 12:16:15 +0100
Subject: [PATCH net-next 08/27] net: mvpp2: remove unused register definitions
In-Reply-To: <1482318994-23488-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1482318994-23488-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1482318994-23488-9-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 98edcb6..e11eb6f 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -253,10 +253,6 @@
 #define MVPP2_SRC_ADDR_HIGH			0x28
 #define MVPP2_PHY_AN_CFG0_REG			0x34
 #define     MVPP2_PHY_AN_STOP_SMI0_MASK		BIT(7)
-#define MVPP2_MIB_COUNTERS_BASE(port)		(0x1000 + ((port) >> 1) * \
-						0x400 + (port) * 0x400)
-#define     MVPP2_MIB_LATE_COLLISION		0x7c
-#define MVPP2_ISR_SUM_MASK_REG			0x220c
 #define MVPP2_MNG_EXTENDED_GLOBAL_CTRL_REG	0x305c
 #define MVPP2_EXT_GLOBAL_CTRL_DEFAULT		0x27
 
-- 
2.7.4
