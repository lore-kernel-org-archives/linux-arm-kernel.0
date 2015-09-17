From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Sep 2015 17:59:17 +0900
Subject: [PATCH 01/21] ARM: shmobile: Remove unused declaration of
 r8a7778_add_standard_devices_dt()
In-Reply-To: <cover.1442478814.git.horms+renesas@verge.net.au>
References: <cover.1442478814.git.horms+renesas@verge.net.au>
Message-ID: <08a0a2409fd0684a1184bf90486b0286a2ba1194.1442478814.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The actual implementation was removed by commit 40216263d3d0b9b4 ("ARM:
shmobile: Remove unused r8a7778 auxdata and callback") in v3.12.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/r8a7778.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/r8a7778.h b/arch/arm/mach-shmobile/r8a7778.h
index f64fedb1f2cc..0e77f3f81123 100644
--- a/arch/arm/mach-shmobile/r8a7778.h
+++ b/arch/arm/mach-shmobile/r8a7778.h
@@ -63,7 +63,6 @@ enum {
 };
 
 extern void r8a7778_add_standard_devices(void);
-extern void r8a7778_add_standard_devices_dt(void);
 extern void r8a7778_add_dt_devices(void);
 
 extern void r8a7778_init_late(void);
-- 
2.1.4
