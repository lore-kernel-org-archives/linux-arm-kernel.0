From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 13 Feb 2013 00:44:48 +0900
Subject: [PATCH 01/06] ARM: shmobile: Remove unused headers from hotplug.c
In-Reply-To: <20130212154438.13067.77359.sendpatchset@w520>
References: <20130212154438.13067.77359.sendpatchset@w520>
Message-ID: <20130212154448.13067.88825.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

This file has no SoC-specific references in it, and
fortunately it is still independent of OF so there
is no real reason to drag in these headers.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/hotplug.c |    4 ----
 1 file changed, 4 deletions(-)

--- 0001/arch/arm/mach-shmobile/hotplug.c
+++ work/arch/arm/mach-shmobile/hotplug.c	2013-02-12 23:44:08.000000000 +0900
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
 
