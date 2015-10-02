From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  2 Oct 2015 10:55:07 +0100
Subject: [PATCHv4 5/6] MAINTAINERS: update ARM PMU profiling and debugging for
 arm64
In-Reply-To: <1443779708-26789-1-git-send-email-mark.rutland@arm.com>
References: <1443779708-26789-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1443779708-26789-6-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon maintains the profiling and debugging code under both
arch/arm and arch/arm64. Update MAINTAINERS to reflect this, in
preparation for adding myself as a reviewer of said code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ba7ab7..236465e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -817,11 +817,11 @@ F:	arch/arm/include/asm/floppy.h
 ARM PMU PROFILING AND DEBUGGING
 M:	Will Deacon <will.deacon@arm.com>
 S:	Maintained
-F:	arch/arm/kernel/perf_*
+F:	arch/arm*/kernel/perf_*
 F:	arch/arm/oprofile/common.c
-F:	arch/arm/kernel/hw_breakpoint.c
-F:	arch/arm/include/asm/hw_breakpoint.h
-F:	arch/arm/include/asm/perf_event.h
+F:	arch/arm*/kernel/hw_breakpoint.c
+F:	arch/arm*/include/asm/hw_breakpoint.h
+F:	arch/arm*/include/asm/perf_event.h
 F:	drivers/perf/arm_pmu.c
 F:	include/linux/perf/arm_pmu.h
 
-- 
1.9.1
