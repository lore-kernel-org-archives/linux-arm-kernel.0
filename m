From: galak@codeaurora.org (Kumar Gala)
Date: Tue,  9 Sep 2014 10:36:46 -0500
Subject: [PATCH v4 1/3] ahci-platform: Bump max number of clocks to 5
Message-ID: <1410277008-20242-1-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Qualcomm IPQ806x SoCs with SATA controllers need 5 clocks to be enabled.

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
(reposted with Hans on list)

v4:
* Updated to upstream changes

 drivers/ata/ahci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 59ae0ee..90156ff 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -53,7 +53,7 @@
 
 enum {
 	AHCI_MAX_PORTS		= 32,
-	AHCI_MAX_CLKS		= 4,
+	AHCI_MAX_CLKS		= 5,
 	AHCI_MAX_SG		= 168, /* hardware max is 64K */
 	AHCI_DMA_BOUNDARY	= 0xffffffff,
 	AHCI_MAX_CMDS		= 32,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
