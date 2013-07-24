From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 24 Jul 2013 12:37:43 +0900
Subject: [PATCH 03/08] ARM: shmobile: Remove EMEV2 use of <mach/hardware.h>
In-Reply-To: <20130724033715.30567.82782.sendpatchset@w520>
References: <20130724033715.30567.82782.sendpatchset@w520>
Message-ID: <20130724033743.30567.57468.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove unused <mach/hardware.h> on EMEV2.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-emev2.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2013-07-23 16:01:44.000000000 +0900
@@ -27,7 +27,6 @@
 #include <linux/input.h>
 #include <linux/io.h>
 #include <linux/irqchip/arm-gic.h>
-#include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/emev2.h>
 #include <mach/irqs.h>
