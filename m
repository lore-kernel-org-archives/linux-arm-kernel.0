From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 24 Jul 2013 12:37:34 +0900
Subject: [PATCH 02/08] ARM: shmobile: Remove sh7372 use of <mach/hardware.h>
In-Reply-To: <20130724033715.30567.82782.sendpatchset@w520>
References: <20130724033715.30567.82782.sendpatchset@w520>
Message-ID: <20130724033734.30567.25082.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove unused <mach/hardware.h> on sh7372.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-sh7372.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2013-07-23 16:00:52.000000000 +0900
@@ -35,7 +35,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/platform_data/sh_ipmmu.h>
 #include <mach/dma-register.h>
-#include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/sh7372.h>
 #include <mach/common.h>
