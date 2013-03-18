From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:46:53 +0900
Subject: [PATCH 01/43] ARM: shmobile: Remove unused headers from hotplug.c
In-Reply-To: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
References: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363607255-6385-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

This file has no SoC-specific references in it, and
fortunately it is still independent of OF so there
is no real reason to drag in these headers.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/hotplug.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/hotplug.c b/arch/arm/mach-shmobile/hotplug.c
index a1524e3..efd0b36 100644
--- a/arch/arm/mach-shmobile/hotplug.c
+++ b/arch/arm/mach-shmobile/hotplug.c
@@ -14,12 +14,8 @@
 #include <linux/smp.h>
 #include <linux/cpumask.h>
 #include <linux/delay.h>
-#include <linux/of.h>
 #include <mach/common.h>
-#include <mach/r8a7779.h>
-#include <mach/emev2.h>
 #include <asm/cacheflush.h>
-#include <asm/mach-types.h>
 
 static cpumask_t dead_cpus;
 
-- 
1.7.10.4
