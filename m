From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 15 Jan 2018 11:13:14 -0700
Subject: [PATCH v2 10/10] MAINTAINERS: Adding entry for CoreSight trace
 decoding
In-Reply-To: <1516039994-314-1-git-send-email-mathieu.poirier@linaro.org>
References: <1516039994-314-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1516039994-314-11-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tor Jeremiassen <tor@ti.com>

Adding maintainers for Coresight trace decoding via perf tools.

Signed-off-by: Tor Jeremiassen <tor@ti.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 95c3fa1f520f..ca333cfce97f 100644
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
2.7.4
