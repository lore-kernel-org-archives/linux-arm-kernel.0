From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 17 Sep 2010 15:17:57 +0530
Subject: [PATCH 13/14] omap4: Panda: Add DEBUG_LL support
In-Reply-To: <1284716878-27667-13-git-send-email-santosh.shilimkar@ti.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-4-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-5-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-6-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-7-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-8-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-9-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-10-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-11-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-12-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-13-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1284716878-27667-14-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Anders <x0132446@ti.com>

Add support for use of DEBUG_LL for use with PandaBoard.

Signed-off-by: David Anders <x0132446@ti.com>
---
 arch/arm/plat-omap/include/plat/uncompress.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index ddf723b..57dffa7 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -153,6 +153,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 
 		/* omap4 based boards using UART3 */
 		DEBUG_LL_OMAP4(3, omap_4430sdp);
+		DEBUG_LL_OMAP4(3, omap4_panda);
 
 		/* zoom2/3 external uart */
 		DEBUG_LL_ZOOM(omap_zoom2);
-- 
1.6.0.4
