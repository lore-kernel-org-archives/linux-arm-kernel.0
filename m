From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Tue,  6 Jun 2017 16:08:59 -0500
Subject: [PATCH v8 24/24] drivers/fsi: Add module license to core driver
In-Reply-To: <20170606210859.80431-1-cbostic@linux.vnet.ibm.com>
References: <20170606210859.80431-1-cbostic@linux.vnet.ibm.com>
Message-ID: <20170606210859.80431-25-cbostic@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing MODULE_LICENSE("GPL") to the core FSI driver.

Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
---
 drivers/fsi/fsi-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index b56f4ed..a485864 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -896,4 +896,5 @@ static void fsi_exit(void)
 module_init(fsi_init);
 module_exit(fsi_exit);
 module_param(discard_errors, int, 0664);
+MODULE_LICENSE("GPL");
 MODULE_PARM_DESC(discard_errors, "Don't invoke error handling on bus accesses");
-- 
1.8.2.2
