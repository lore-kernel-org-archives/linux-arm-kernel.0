From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 27 Sep 2012 10:33:32 -0600
Subject: [PATCH 3/6] cpufreq: OMAP: remove unnecessary include of plat/clock.h
In-Reply-To: <20120927162800.21755.62891.stgit@dusk.lan>
References: <20120927162800.21755.62891.stgit@dusk.lan>
Message-ID: <20120927163331.21755.69249.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove an unnecessary include of arch/arm/plat-omap/include/plat/clock.h
to facilitate the ARM single kernel image work.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 drivers/cpufreq/omap-cpufreq.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index b47034e..1c9eff6 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -30,7 +30,6 @@
 #include <asm/smp_plat.h>
 #include <asm/cpu.h>
 
-#include <plat/clock.h>
 #include <plat/omap-pm.h>
 #include <plat/common.h>
 #include <plat/omap_device.h>
