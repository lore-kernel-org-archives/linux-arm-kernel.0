From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 23 Dec 2011 23:27:19 +0530
Subject: [PATCH 1/2] ARM: davinci: time.c: group related header files together
Message-ID: <1324663040-2859-1-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rearrange header files to keep related header files
together.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/time.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index e1969ce..f2afb2d 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -19,11 +19,13 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 
-#include <mach/hardware.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
+
 #include <mach/cputype.h>
+#include <mach/hardware.h>
 #include <mach/time.h>
+
 #include "clock.h"
 
 static struct clock_event_device clockevent_davinci;
-- 
1.6.2.4
