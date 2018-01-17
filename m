From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 17 Jan 2018 10:52:19 -0700
Subject: [PATCH v3 10/10] MAINTAINERS: Adding entry for CoreSight trace
 decoding
In-Reply-To: <1516211539-5166-1-git-send-email-mathieu.poirier@linaro.org>
References: <1516211539-5166-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1516211539-5166-11-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tor Jeremiassen <tor@ti.com>

Adding maintainers for Coresight trace decoding via perf tools.

Signed-off-by: Tor Jeremiassen <tor@ti.com>
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
2.7.4
