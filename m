From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sat, 16 Apr 2016 01:29:27 +0800
Subject: [PATCH 03/23] mmc: core: fix a comment typo
In-Reply-To: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1460741387-23815-4-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/core/mmc_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 62355bd..d220bbd 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -553,7 +553,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 
 		/*
 		 * We are not allowed to issue a status command and the host
-		 * does'nt support MMC_CAP_WAIT_WHILE_BUSY, then we can only
+		 * doesn't support MMC_CAP_WAIT_WHILE_BUSY, then we can only
 		 * rely on waiting for the stated timeout to be sufficient.
 		 */
 		if (!send_status) {
-- 
1.9.1
