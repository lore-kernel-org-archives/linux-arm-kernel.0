From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 25 Oct 2012 18:40:54 +0200
Subject: [PATCH] arm: mvebu: fix typo in machine name for Armada 370/XP
Message-ID: <1351183255-4979-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/armada-370-xp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index 1c0021d..9618148 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -53,7 +53,7 @@ static const char * const armada_370_xp_dt_board_dt_compat[] = {
 	NULL,
 };
 
-DT_MACHINE_START(ARMADA_XP_DT, "Marvell Aramada 370/XP (Device Tree)")
+DT_MACHINE_START(ARMADA_XP_DT, "Marvell Armada 370/XP (Device Tree)")
 	.init_machine	= armada_370_xp_dt_init,
 	.map_io		= armada_370_xp_map_io,
 	.init_irq	= armada_370_xp_init_irq,
-- 
1.7.9.5
