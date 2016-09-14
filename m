From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 14 Sep 2016 17:32:38 -0500
Subject: [PATCH v9 10/10] MAINTAINERS: Tweak ARM PMU maintainers
In-Reply-To: <1473892358-22574-1-git-send-email-jeremy.linton@arm.com>
References: <1473892358-22574-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1473892358-22574-11-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the ARM PMU file list, and add the arm mailing list.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1fbd77d..246b427 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -915,12 +915,13 @@ ARM PMU PROFILING AND DEBUGGING
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
