From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Tue, 23 Jan 2018 10:12:45 -0300
Subject: [PATCH 37/43] MAINTAINERS: Adding entry for CoreSight trace decoding
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Message-ID: <20180123131251.28197-38-acme@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tor Jeremiassen <tor@ti.com>

Adding maintainers for Coresight trace decoding via perf tools.

Signed-off-by: Tor Jeremiassen <tor@ti.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Mike Leach <mike.leach@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Link: http://lkml.kernel.org/r/1516211539-5166-11-git-send-email-mathieu.poirier at linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d76af75a653a..7eafa087dda3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1313,7 +1313,8 @@ F:	tools/perf/arch/arm/util/pmu.c
 F:	tools/perf/arch/arm/util/auxtrace.c
 F:	tools/perf/arch/arm/util/cs-etm.c
 F:	tools/perf/arch/arm/util/cs-etm.h
-F:	tools/perf/util/cs-etm.h
+F:	tools/perf/util/cs-etm.*
+F:	tools/perf/util/cs-etm-decoder/*
 
 ARM/CORGI MACHINE SUPPORT
 M:	Richard Purdie <rpurdie@rpsys.net>
-- 
2.14.3
