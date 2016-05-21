From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:51:09 +0200
Subject: [PATCH 0114/1529] Fix typo
Message-ID: <20160521115109.5318-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-rockchip/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/pm.c b/arch/arm/mach-rockchip/pm.c
index bee8c80..309d672 100644
--- a/arch/arm/mach-rockchip/pm.c
+++ b/arch/arm/mach-rockchip/pm.c
@@ -280,7 +280,7 @@ static int rk3288_suspend_init(struct device_node *np)
 
 	rk3288_config_bootdata();
 
-	/* copy resume code and data to bootsram */
+	/* copy resume code and data to bootram */
 	memcpy(rk3288_bootram_base, rockchip_slp_cpu_resume,
 	       rk3288_bootram_sz);
 
-- 
2.8.2.534.g1f66975
