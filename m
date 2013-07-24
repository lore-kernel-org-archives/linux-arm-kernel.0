From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 24 Jul 2013 12:38:01 +0900
Subject: [PATCH 05/08] ARM: shmobile: Remove AG5EVM use of <mach/hardware.h>
In-Reply-To: <20130724033715.30567.82782.sendpatchset@w520>
References: <20130724033715.30567.82782.sendpatchset@w520>
Message-ID: <20130724033801.30567.89261.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove unused <mach/hardware.h> on AG5EVM.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-ag5evm.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-ag5evm.c
+++ work/arch/arm/mach-shmobile/board-ag5evm.c	2013-07-23 16:03:31.000000000 +0900
@@ -47,7 +47,6 @@
 #include <video/sh_mobile_lcdc.h>
 #include <video/sh_mipi_dsi.h>
 #include <sound/sh_fsi.h>
-#include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
