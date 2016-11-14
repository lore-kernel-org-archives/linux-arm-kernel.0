From: colin.king@canonical.com (Colin King)
Date: Mon, 14 Nov 2016 23:04:00 +0000
Subject: [PATCH] ARM: socfpga: fix spelling mistake in error message
Message-ID: <20161114230400.5352-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake "Mananger" to "Manager"
in error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/arm/mach-socfpga/l2_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/l2_cache.c b/arch/arm/mach-socfpga/l2_cache.c
index 4267c95f..bb359d7 100644
--- a/arch/arm/mach-socfpga/l2_cache.c
+++ b/arch/arm/mach-socfpga/l2_cache.c
@@ -74,7 +74,7 @@ void socfpga_init_arria10_l2_ecc(void)
 	}
 
 	if (!sys_manager_base_addr) {
-		pr_err("System Mananger not mapped for L2 ECC\n");
+		pr_err("System Manager not mapped for L2 ECC\n");
 		goto exit;
 	}
 	/* Clear any pending IRQs */
-- 
2.10.2
