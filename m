From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:50:20 +0900
Subject: [PATCH] ARM: shmobile: marzen-reference: Don't include legacy clock.h
In-Reply-To: <cover.1415059054.git.horms+renesas@verge.net.au>
References: <cover.1415059054.git.horms+renesas@verge.net.au>
Message-ID: <803fc9b590f74ef1066be328f2f33c2b285ca3af.1415059054.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The marzen-reference board file doesn't need the clock.h header, don't
include it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen-reference.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 38d9cdd..644883a 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -26,7 +26,6 @@
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 
-#include "clock.h"
 #include "common.h"
 #include "irqs.h"
 #include "r8a7779.h"
-- 
2.1.1
