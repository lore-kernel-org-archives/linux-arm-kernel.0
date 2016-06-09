From: jeremy.linton@arm.com (Jeremy Linton)
Date: Thu,  9 Jun 2016 17:23:33 -0500
Subject: [PATCH 8/8] MAINTAINERS: Tweak ARM PMU maintainers
In-Reply-To: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
References: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1465511013-10742-9-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the ARM PMU file list, and add the arm mailing list.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ed42cb6..cd1f9d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -878,12 +878,13 @@ ARM PMU PROFILING AND DEBUGGING
 M:	Will Deacon <will.deacon@arm.com>
 R:	Mark Rutland <mark.rutland@arm.com>
 S:	Maintained
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 F:	arch/arm*/kernel/perf_*
 F:	arch/arm/oprofile/common.c
 F:	arch/arm*/kernel/hw_breakpoint.c
 F:	arch/arm*/include/asm/hw_breakpoint.h
 F:	arch/arm*/include/asm/perf_event.h
-F:	drivers/perf/arm_pmu.c
+F:	drivers/perf/arm_pmu*
 F:	include/linux/perf/arm_pmu.h
 
 ARM PORT
-- 
2.5.5
