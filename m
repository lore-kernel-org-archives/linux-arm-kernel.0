From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 13 Jun 2013 16:03:47 +0530
Subject: [PATCH] ARM: davinci: remove stale SFFSDR maintainer name
Message-ID: <1371119627-24391-1-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hugo Villeneuve <hugo@hugovil.com>

The maintainer entry for SFFSDR board contained in the
board file is stale (not working). Remove it.

Signed-off-by: Hugo Villeneuve <hugo@hugovil.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/board-sffsdr.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index 739be7e..513eee1 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -151,7 +151,6 @@ static __init void davinci_sffsdr_init(void)
 }
 
 MACHINE_START(SFFSDR, "Lyrtech SFFSDR")
-	/* Maintainer: Hugo Villeneuve hugo.villeneuve at lyrtech.com */
 	.atag_offset  = 0x100,
 	.map_io	      = davinci_sffsdr_map_io,
 	.init_irq     = davinci_irq_init,
-- 
1.7.10.1
