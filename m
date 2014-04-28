From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 17:57:52 +0100
Subject: [PATCH 01/16] ARM: l2c: bcm - remove UL (needs folding into earlier
 patch)
In-Reply-To: <20140428165631.GM26756@n2100.arm.linux.org.uk>
References: <20140428165631.GM26756@n2100.arm.linux.org.uk>
Message-ID: <E1WeosK-0002PK-2q@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-bcm/bcm_5301x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-bcm/bcm_5301x.c b/arch/arm/mach-bcm/bcm_5301x.c
index edff69761e04..6bc9c31b1b0b 100644
--- a/arch/arm/mach-bcm/bcm_5301x.c
+++ b/arch/arm/mach-bcm/bcm_5301x.c
@@ -45,7 +45,7 @@ static void __init bcm5301x_init_early(void)
 
 static void __init bcm5301x_dt_init(void)
 {
-	l2x0_of_init(0, ~0UL);
+	l2x0_of_init(0, ~0);
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
1.8.3.1
