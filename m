From: isubramanian@apm.com (Iyappan Subramanian)
Date: Wed, 10 May 2017 13:45:04 -0700
Subject: [PATCH v2 net-next 06/12] drivers: net: xgene: Remove unused macros
In-Reply-To: <1494449110-23785-1-git-send-email-isubramanian@apm.com>
References: <1494449110-23785-1-git-send-email-isubramanian@apm.com>
Message-ID: <1494449110-23785-7-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Quan Nguyen <qnguyen@apm.com>

This patch cleans up unused macros to improve readability.

Signed-off-by: Quan Nguyen <qnguyen@apm.com>
Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
index 3ce349f..ed51005 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
@@ -217,12 +217,6 @@ enum xgene_enet_rm {
 #define FULL_DUPLEX2			BIT(0)
 #define PAD_CRC				BIT(2)
 #define LENGTH_CHK			BIT(4)
-#define SCAN_AUTO_INCR			BIT(5)
-#define TBYT_ADDR			0x38
-#define TPKT_ADDR			0x39
-#define TDRP_ADDR			0x45
-#define TFCS_ADDR			0x47
-#define TUND_ADDR			0x4a
 
 #define TSO_IPPROTO_TCP			1
 
-- 
1.9.1
