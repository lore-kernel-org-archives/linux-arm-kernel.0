From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat,  2 Jul 2016 19:23:13 +0000
Subject: [PATCH 1/2] mmc: sdhci: add define for suspend/resume capability
In-Reply-To: <1467487394-28682-1-git-send-email-stefan.wahren@i2se.com>
References: <1467487394-28682-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1467487394-28682-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing define for the suspend/resume
capability (according to SD Host Controller spec).

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/sdhci.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 609f87c..42584f0 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -186,6 +186,7 @@
 #define  SDHCI_CAN_DO_ADMA1	0x00100000
 #define  SDHCI_CAN_DO_HISPD	0x00200000
 #define  SDHCI_CAN_DO_SDMA	0x00400000
+#define  SDHCI_CAN_DO_SUSPEND	0x00800000
 #define  SDHCI_CAN_VDD_330	0x01000000
 #define  SDHCI_CAN_VDD_300	0x02000000
 #define  SDHCI_CAN_VDD_180	0x04000000
-- 
1.7.9.5
