From: jeremy.linton@arm.com (Jeremy Linton)
Date: Tue, 23 Aug 2016 15:48:00 -0500
Subject: [PATCH v7 9/9] MAINTAINERS: Tweak ARM PMU maintainers
In-Reply-To: <1471985280-2243-1-git-send-email-jeremy.linton@arm.com>
References: <1471985280-2243-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1471985280-2243-10-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the ARM PMU file list, and add the arm mailing list.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0bbe4b1..d293270 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -905,12 +905,13 @@ ARM PMU PROFILING AND DEBUGGING
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
