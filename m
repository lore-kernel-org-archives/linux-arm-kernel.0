From: felipe.balbi@nokia.com (Felipe Balbi)
Date: Wed, 30 Dec 2009 00:59:24 +0200
Subject: [patch-v2.6.34 6/9] arm: omap: gpmc: avoid section definitions on
	headers
In-Reply-To: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com>
References: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com>
Message-ID: <1262127567-15202-7-git-send-email-felipe.balbi@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

trivial patch, no functional changes.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
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
-- 
1.6.6.35.g1d85d
