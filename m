From: weber@corscience.de (Thomas Weber)
Date: Tue, 21 Dec 2010 12:07:09 +0100
Subject: [PATCH] OMAP3: Devkit8000: Add DEBUG_LL support
Message-ID: <1292929629-3396-1-git-send-email-weber@corscience.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for DEBUG_LL for Devkit8000.
Devkit8000 uses uart 3 for debug output.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/plat-omap/include/plat/uncompress.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index 7bbc074..ad98b85 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -146,6 +146,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		DEBUG_LL_OMAP3(3, cm_t35);
 		DEBUG_LL_OMAP3(3, cm_t3517);
 		DEBUG_LL_OMAP3(3, craneboard);
+		DEBUG_LL_OMAP3(3, devkit8000);
 		DEBUG_LL_OMAP3(3, igep0020);
 		DEBUG_LL_OMAP3(3, igep0030);
 		DEBUG_LL_OMAP3(3, nokia_rm680);
-- 
1.7.3.4
