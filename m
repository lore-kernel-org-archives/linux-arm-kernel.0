From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Mon,  4 Jun 2018 15:08:35 +0800
Subject: [PATCH 08/10] fsl/fman: define frame description command UPD
In-Reply-To: <20180604070837.19265-1-yangbo.lu@nxp.com>
References: <20180604070837.19265-1-yangbo.lu@nxp.com>
Message-ID: <20180604070837.19265-9-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Defined frame description command FM_FD_CMD_UPD for
prepended data updating.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/net/ethernet/freescale/fman/fman.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.h b/drivers/net/ethernet/freescale/fman/fman.h
index bfa02e0..935c317 100644
--- a/drivers/net/ethernet/freescale/fman/fman.h
+++ b/drivers/net/ethernet/freescale/fman/fman.h
@@ -41,6 +41,7 @@
 /* Frame queue Context Override */
 #define FM_FD_CMD_FCO                   0x80000000
 #define FM_FD_CMD_RPD                   0x40000000  /* Read Prepended Data */
+#define FM_FD_CMD_UPD			0x20000000  /* Update Prepended Data */
 #define FM_FD_CMD_DTC                   0x10000000  /* Do L4 Checksum */
 
 /* TX-Port: Unsupported Format */
-- 
1.7.1
