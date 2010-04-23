From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Apr 2010 16:12:00 -0700
Subject: [PATCH 24/28] omap: Devkit8000: Fix typo in pin name
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Message-ID: <20100423231200.31953.17777.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Weber <weber@corscience.de>

Replace wrong sdr_cke[01] with sdrc_cke[01].

Signed-off-by: Thomas Weber <weber@corscience.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-devkit8000.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index b82e438..3fafef4 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -676,8 +676,8 @@ static void __init devkit8000_init(void)
 	devkit8000_flash_init();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
-	omap_mux_init_signal("sdr_cke0", OMAP_PIN_OUTPUT);
-	omap_mux_init_signal("sdr_cke1", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
 }
 
 static void __init devkit8000_map_io(void)
