From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  6 Jul 2015 12:24:01 +0100
Subject: [PATCHv3 9/9] MAINTAINERS: add myself as arm perf reviewer
In-Reply-To: <1436181842-19402-1-git-send-email-mark.rutland@arm.com>
References: <1436181842-19402-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1436181842-19402-10-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As suggested by Will Deacon, add myself as a reviewer of the ARM PMU
profiling and debugging code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ee006bd..c90fdab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -798,6 +798,7 @@ F:	arch/arm/include/asm/floppy.h
 
 ARM PMU PROFILING AND DEBUGGING
 M:	Will Deacon <will.deacon@arm.com>
+R:	Mark Rutland <mark.rutland@arm.com>
 S:	Maintained
 F:	arch/arm*/kernel/perf_*
 F:	arch/arm/oprofile/common.c
-- 
1.9.1
