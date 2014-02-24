From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 24 Feb 2014 14:41:54 +0900
Subject: [PATCH 06/12] ARM: shmobile: Rework include path for r8a7778
In-Reply-To: <20140224054058.1143.14096.sendpatchset@w520>
References: <20140224054058.1143.14096.sendpatchset@w520>
Message-ID: <20140224054154.1143.39830.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Convert r8a7778 SoC code use of include files from 
the style <mach/something.h> to "something.h".

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-r8a7778.c |    4 ++--
 arch/arm/mach-shmobile/setup-r8a7778.c |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-r8a7778.c
+++ work/arch/arm/mach-shmobile/clock-r8a7778.c	2014-02-24 13:38:19.000000000 +0900
@@ -39,8 +39,8 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/clock.h>
-#include <mach/common.h>
+#include "clock.h"
+#include "common.h"
 
 #define MSTPCR0		IOMEM(0xffc80030)
 #define MSTPCR1		IOMEM(0xffc80034)
--- 0001/arch/arm/mach-shmobile/setup-r8a7778.c
+++ work/arch/arm/mach-shmobile/setup-r8a7778.c	2014-02-24 13:37:06.000000000 +0900
@@ -37,9 +37,9 @@
 #include <linux/usb/ehci_pdriver.h>
 #include <linux/usb/ohci_pdriver.h>
 #include <linux/dma-mapping.h>
-#include <mach/irqs.h>
-#include <mach/r8a7778.h>
-#include <mach/common.h>
+#include "irqs.h"
+#include "r8a7778.h"
+#include "common.h"
 #include <asm/mach/arch.h>
 #include <asm/hardware/cache-l2x0.h>
 
