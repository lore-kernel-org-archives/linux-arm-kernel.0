From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Sep 2015 17:59:23 +0900
Subject: [PATCH 07/21] ARM: shmobile: Remove obsolete twd_local_timer
 declaration
In-Reply-To: <cover.1442478814.git.horms+renesas@verge.net.au>
References: <cover.1442478814.git.horms+renesas@verge.net.au>
Message-ID: <b62708ac3f5ebfd3a15bd65fd48ed013c5f166bf.1442478814.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The last user of twd_local_timer was removed in commit c99cd90d98a98aa1
("ARM: shmobile: r8a7779: Remove legacy SoC code").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 2a350b48b893..0833a6ed02e4 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -2,7 +2,6 @@
 #define __ARCH_MACH_COMMON_H
 
 extern void shmobile_init_delay(void);
-struct twd_local_timer;
 extern void shmobile_boot_vector(void);
 extern unsigned long shmobile_boot_fn;
 extern unsigned long shmobile_boot_arg;
-- 
2.1.4
