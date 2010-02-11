From: tony@atomide.com (Tony Lindgren)
Date: Wed, 10 Feb 2010 19:36:09 -0800
Subject: [PATCH 13/17] omap2/3/4: gpmc: avoid section definitions on headers
In-Reply-To: <20100211033310.1624.80025.stgit@baageli.muru.com>
References: <20100211033310.1624.80025.stgit@baageli.muru.com>
Message-ID: <20100211033609.1624.84009.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <felipe.balbi@nokia.com>

trivial patch, no functional changes.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/gpmc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index e081338..3f3609a 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -110,6 +110,6 @@ extern void gpmc_prefetch_reset(void);
 extern int gpmc_prefetch_status(void);
 extern void omap3_gpmc_save_context(void);
 extern void omap3_gpmc_restore_context(void);
-extern void __init gpmc_init(void);
+extern void gpmc_init(void);
 
 #endif
