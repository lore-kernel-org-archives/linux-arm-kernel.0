From: will.deacon@arm.com (Will Deacon)
Date: Wed, 29 Jun 2011 18:59:38 +0100
Subject: [PATCH] ARM: MAINTAINERS: add entry for ARM PMU profiling and
	debugging
Message-ID: <1309370378-30301-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following a request from Russell King:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/055031.html

Add myself as the ARM PMU profiling and debugging maintainer. This
covers the ARM implementations of perf, oprofile and hw_breakpoint along
with the glue for this to work on different platforms.

Cc: Jean Pihet <j-pihet@ti.com>
Acked-by: Jamie Iles <jamie@jamieiles.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 MAINTAINERS |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f0358cd..3e7898c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -594,6 +594,16 @@ S:	Maintained
 F:	arch/arm/lib/floppydma.S
 F:	arch/arm/include/asm/floppy.h
 
+ARM PMU PROFILING AND DEBUGGING
+M:	Will Deacon <will.deacon@arm.com>
+S:	Maintained
+F:	arch/arm/kernel/perf_event*
+F:	arch/arm/oprofile/common.c
+F:	arch/arm/kernel/pmu.c
+F:	arch/arm/include/asm/pmu.h
+F:	arch/arm/kernel/hw_breakpoint.c
+F:	arch/arm/include/asm/hw_breakpoint.h
+
 ARM PORT
 M:	Russell King <linux@arm.linux.org.uk>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
1.7.0.4
