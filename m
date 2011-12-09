From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  9 Dec 2011 22:50:51 +0100
Subject: [PATCH] ARM: provide XIP_VIRT_ADDR for no-MMU builds
Message-ID: <1323467451-12128-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/include/asm/memory.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index a8997d7..fcb5757 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -116,6 +116,8 @@
 #define MODULES_END		(END_MEM)
 #define MODULES_VADDR		(PHYS_OFFSET)
 
+#define XIP_VIRT_ADDR(physaddr)  (physaddr)
+
 #endif /* !CONFIG_MMU */
 
 /*
-- 
1.7.7.3
