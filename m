From: christopher.lee.bostic@gmail.com (christopher.lee.bostic at gmail.com)
Date: Thu, 12 Jan 2017 16:37:35 -0600
Subject: [PATCH v2 18/18] insert build break
Message-ID: <1484260655-80477-1-git-send-email-christopher.lee.bostic@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Bostic <cbostic@us.ibm.com>

Signed-off-by: Chris Bostic <cbostic@us.ibm.com>
---
 drivers/fsi/fsi-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 28b82d1..db09836 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -42,6 +42,7 @@
 
 static DEFINE_IDA(master_ida);
 
+
 struct fsi_slave {
 	struct device		dev;
 	struct fsi_master	*master;
-- 
1.8.2.2
