From: tim.nordell@logicpd.com (Tim Nordell)
Date: Fri, 24 Sep 2010 18:12:50 -0500
Subject: [PATCH v3 5/5] ARM: OMAP3LOGIC: Adding low-level debug support
In-Reply-To: <1285358338-3403-1-git-send-email-tim.nordell@logicpd.com>
References: <1285358338-3403-1-git-send-email-tim.nordell@logicpd.com>
Message-ID: <1285369970-29454-6-git-send-email-tim.nordell@logicpd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Defined UART1 as the low-level debug port for both the
omap3530_lv_som board and the omap3_torpedo board.

Signed-off-by: Tim Nordell <tim.nordell@logicpd.com>
---
 arch/arm/plat-omap/include/plat/uncompress.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index ddf723b..ff9f3a2 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -139,6 +139,8 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		DEBUG_LL_OMAP2(1, omap3evm);
 		DEBUG_LL_OMAP3(1, omap_3430sdp);
 		DEBUG_LL_OMAP3(1, omap_3630sdp);
+		DEBUG_LL_OMAP3(1, omap3530_lv_som);
+		DEBUG_LL_OMAP3(1, omap3_torpedo);
 
 		/* omap3 based boards using UART3 */
 		DEBUG_LL_OMAP3(3, cm_t35);
-- 
1.7.1
