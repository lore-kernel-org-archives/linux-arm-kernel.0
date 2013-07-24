From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 24 Jul 2013 12:38:11 +0900
Subject: [PATCH 06/08] ARM: shmobile: Remove Kota2 use of <mach/hardware.h>
In-Reply-To: <20130724033715.30567.82782.sendpatchset@w520>
References: <20130724033715.30567.82782.sendpatchset@w520>
Message-ID: <20130724033811.30567.3910.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove unused <mach/hardware.h> on Kota2.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-kota2.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-kota2.c
+++ work/arch/arm/mach-shmobile/board-kota2.c	2013-07-23 16:04:07.000000000 +0900
@@ -44,7 +44,6 @@
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
-#include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
