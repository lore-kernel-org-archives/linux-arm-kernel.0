From: weber@corscience.de (Thomas Weber)
Date: Wed, 19 Jan 2011 09:19:26 +0100
Subject: [PATCHv4 4/4] OMAP3: Devkit8000: Fix indentation of brace
In-Reply-To: <1295425166-25540-1-git-send-email-weber@corscience.de>
References: <1295425166-25540-1-git-send-email-weber@corscience.de>
Message-ID: <1295425166-25540-5-git-send-email-weber@corscience.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix indentation of a closing curly brace.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 4ddd81c..a344cd8 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -553,7 +553,7 @@ static void __init omap_dm9000_init(void)
 		printk(KERN_ERR "Failed to request GPIO%d for dm9000 IRQ\n",
 			OMAP_DM9000_GPIO_IRQ);
 		return;
-		}
+	}
 
 	gpio_direction_input(OMAP_DM9000_GPIO_IRQ);
 
-- 
1.7.4.rc2
