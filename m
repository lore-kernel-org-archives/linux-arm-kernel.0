From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 18 Oct 2012 04:01:27 +0200
Subject: [PATCH] ARM: mm: Remove unused arm_vmregion priv field
Message-ID: <1350525687-2396-1-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e9da6e9905e639b0f842a244bc770b48ad0523e9 ("ARM: dma-mapping:
remove custom consistent dma region") removed the last users of the
field. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mm/vmregion.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/vmregion.h b/arch/arm/mm/vmregion.h
index bf312c3..0f5a5f2 100644
--- a/arch/arm/mm/vmregion.h
+++ b/arch/arm/mm/vmregion.h
@@ -17,7 +17,6 @@ struct arm_vmregion {
 	struct list_head	vm_list;
 	unsigned long		vm_start;
 	unsigned long		vm_end;
-	void			*priv;
 	int			vm_active;
 	const void		*caller;
 };
-- 
Regards,

Laurent Pinchart
