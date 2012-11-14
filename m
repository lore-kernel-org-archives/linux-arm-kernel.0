From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 14 Nov 2012 16:44:36 +0100
Subject: [PATCH 3/3] arm: mvebu: fix typo in machine name for Armada 370/XP
In-Reply-To: <1352907876-32482-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1352907876-32482-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1352907876-32482-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/armada-370-xp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index 29c27cd..a2f5bbc 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -51,7 +51,7 @@ static const char * const armada_370_xp_dt_compat[] = {
 	NULL,
 };
 
-DT_MACHINE_START(ARMADA_XP_DT, "Marvell Aramada 370/XP (Device Tree)")
+DT_MACHINE_START(ARMADA_XP_DT, "Marvell Armada 370/XP (Device Tree)")
 	.init_machine	= armada_370_xp_dt_init,
 	.map_io		= armada_370_xp_map_io,
 	.init_irq	= armada_370_xp_init_irq,
-- 
1.7.9.5
