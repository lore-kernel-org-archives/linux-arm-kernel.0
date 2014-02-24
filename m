From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 24 Feb 2014 14:42:32 +0900
Subject: [PATCH 10/12] ARM: shmobile: Rework include path for r8a73a4
In-Reply-To: <20140224054058.1143.14096.sendpatchset@w520>
References: <20140224054058.1143.14096.sendpatchset@w520>
Message-ID: <20140224054232.1143.56037.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-r8a73a4.c |    4 ++--
 arch/arm/mach-shmobile/setup-r8a73a4.c |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-r8a73a4.c
+++ work/arch/arm/mach-shmobile/clock-r8a73a4.c	2014-02-24 13:53:46.000000000 +0900
@@ -22,8 +22,8 @@
 #include <linux/kernel.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/clock.h>
-#include <mach/common.h>
+#include "clock.h"
+#include "common.h"
 
 #define CPG_BASE 0xe6150000
 #define CPG_LEN 0x270
--- 0001/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ work/arch/arm/mach-shmobile/setup-r8a73a4.c	2014-02-24 13:52:49.000000000 +0900
@@ -24,10 +24,10 @@
 #include <linux/serial_sci.h>
 #include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
-#include <mach/common.h>
-#include <mach/dma-register.h>
-#include <mach/irqs.h>
-#include <mach/r8a73a4.h>
+#include "common.h"
+#include "dma-register.h"
+#include "irqs.h"
+#include "r8a73a4.h"
 #include <asm/mach/arch.h>
 
 static const struct resource pfc_resources[] = {
