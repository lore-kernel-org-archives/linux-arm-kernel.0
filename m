From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:13:19 +0900
Subject: [PATCH 01/15] ARM: shmobile: Remove duplicate inclusion of
 dma-mapping.h in setup-r8a7740.c
In-Reply-To: <1359080013-29189-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080013-29189-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080013-29189-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

linux/dma-mapping.h was included twice.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7740.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 03c69f9..9ef397d 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -27,7 +27,6 @@
 #include <linux/serial_sci.h>
 #include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
-#include <linux/dma-mapping.h>
 #include <mach/dma-register.h>
 #include <mach/r8a7740.h>
 #include <mach/pm-rmobile.h>
-- 
1.7.10.4
