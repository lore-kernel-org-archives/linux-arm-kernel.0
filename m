From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 21 Apr 2012 13:11:21 +0400
Subject: [PATCH 08/17] ARM clps711x: Cleanup: remove unused definitions for
 ep_readl/ep_writel
In-Reply-To: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
References: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
Message-ID: <1334999490-27177-9-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/include/asm/hardware/ep7212.h |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/hardware/ep7212.h b/arch/arm/include/asm/hardware/ep7212.h
index 0b1f508..2672291 100644
--- a/arch/arm/include/asm/hardware/ep7212.h
+++ b/arch/arm/include/asm/hardware/ep7212.h
@@ -25,11 +25,6 @@
 
 #define EP7212_PHYS_BASE	(0x80000000)
 
-#ifndef __ASSEMBLY__
-#define ep_readl(off)		__raw_readl(CLPS7111_BASE + (off))
-#define ep_writel(val,off)	__raw_writel(val, CLPS7111_BASE + (off))
-#endif
-
 /*
  * These registers are specific to the EP7212 only
  */
-- 
1.7.3.4
