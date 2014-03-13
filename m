From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Mar 2014 17:59:54 +0900
Subject: [PATCH v4 11/19] ARM: shmobile: r8a7779: Do not include sh_clk.h in
 r8a7779.h
In-Reply-To: <1394701202-25823-1-git-send-email-horms+renesas@verge.net.au>
References: <1394701202-25823-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1394701202-25823-12-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not include sh_clk.h in r8a7779.h as it is not necessary.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7779.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index d5ba2d8..757b903 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -1,7 +1,6 @@
 #ifndef __ASM_R8A7779_H__
 #define __ASM_R8A7779_H__
 
-#include <linux/sh_clk.h>
 #include <linux/pm_domain.h>
 #include <mach/pm-rcar.h>
 
-- 
1.8.5.2
