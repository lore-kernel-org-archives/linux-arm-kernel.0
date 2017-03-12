From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 12 Mar 2017 14:16:59 +0100
Subject: [PATCH v2 15/23] MAINTAINERS: Add file patterns for perf device tree
 bindings
In-Reply-To: <1489324627-19126-1-git-send-email-geert@linux-m68k.org>
References: <1489324627-19126-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1489324627-19126-16-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
---
Please apply this patch directly if you want to be involved in device
tree binding documentation for your subsystem.

v2:
  - New.

Impact on next-20170310:

-Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS,commit_signer:1/1=100%)
-Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
-Tai Nguyen <ttnguyen@apm.com> (commit_signer:1/1=100%,authored:1/1=100%)
+Will Deacon <will.deacon@arm.com> (maintainer:ARM PMU PROFILING AND DEBUGGING)
+Mark Rutland <mark.rutland@arm.com> (maintainer:ARM PMU PROFILING AND DEBUGGING)
+Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
+linux-arm-kernel at lists.infradead.org (moderated list:ARM PMU PROFILING AND DEBUGGING)
 devicetree at vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
 linux-kernel at vger.kernel.org (open list)
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dfa07200386cd012..896d7238f3f3f4e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -976,6 +976,7 @@ F:	arch/arm*/include/asm/perf_event.h
 F:	drivers/perf/*
 F:	include/linux/perf/arm_pmu.h
 F:	Documentation/devicetree/bindings/arm/pmu.txt
+F:	Documentation/devicetree/bindings/perf/
 
 ARM PORT
 M:	Russell King <linux@armlinux.org.uk>
-- 
2.7.4
